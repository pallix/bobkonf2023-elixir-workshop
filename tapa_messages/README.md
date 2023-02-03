# TapaMessages

Most of the communication between processes, either on a node or between nodes,
happens through message passing. There is no shared memory between processes and
this makes concurrency and distributed programming much easier.

## Goal

## Part 1: REPL explorations

Let's explore message passing in iex.

Starts `iex` like this:

```
iex --name node1@127.0.0.1 -S mix
```

This starts a distributed node with the secret cookie stored in `~/.erlang.cookie`.
Every node on the network (or locally) with the same cookie can communicate together.

The low-level primitives for sending messages are `send` and `receive`, we can send a message
to the current process like this:

```
send(self(), :hello)
```

An Elixir/Erlang system is highly observable and introspectable. We can see that the message queue
of the current process contains one message:

```
Process.info(self()) |> Keyword.get(:message_queue_len)
```

We send one more message:
```
send(self(), :world)
```

Now it has two messages in the queue:
```
Process.info(self()) |> Keyword.get(:message_queue_len)
```

Let's flush the message:

```
flush()
```

We see our messages and the queue is now empty. Flush is only used for `iex`.

Message are not limited to atoms, we can send every Erlang term, inclusive functions.

Execute the `TapaMessages.start_message_receiver` function:

```
pid = TapaMessages.start_message_receiver
```

and send it a message:

```
send(pid, {:hello, "world"})
```

It will print `Received: {:hello, "world"}`. Look at the code to understand how to receive a message.
The `spawn` is needed otherwise `receive` will be executed within the process of the REPL and will block
the REPL waiting for message that we cannot send from the blocked REPL.

Now type this:

```
pid = TapaMessages.start_message_receiver_2()
send(pid, {:ping, self()})
flush()
```

We see that we can send `pids` and have bidirectional communication. Look at the
implementation of `start_message_receiver_2`. Pattern-matching can be used in `receive`.
Note that `receive` does not create a loop, it just blocks until a matching message is received.

Now executes this:

```
pid = TapaMessages.start_message_receiver_2()
send(pid, :some_message)
Process.alive?(pid)
Process.info(pid) |> Keyword.get(:message_queue_len)
send(pid, :some_message_2)
Process.info(pid) |> Keyword.get(:message_queue_len)
```

What is happening? How can we fix this problem?

Now we will see how processes and message passing are related. Look at the code
of `start_two_children`, and then executes it:

```
TapaMessages.start_two_children()
```

It behaves as in the previous tapa. But now look at the code of
`start_two_children_trap_exit`, and then executes this:

```
TapaMessages.start_two_children_trap_exit()

```

and waits 2 seconds. When you see `Type: ...` in the REPL, type what is
indicated. We can see that `child2` is still alive despite its parent having an
error and both processes being linked. Why? Check the
[documentation](https://hexdocs.pm/elixir/1.14/Process.html#exit/2)

The `Received: {:EXIT, #PID<0.351.0>, :some_error}` output shows us that the
communication for the lifecycle of processes happen also with messages (also
called signals).

If process A wants to monitor process B without linking to it, process A can invoke the
function `Process.monitor`. A message will be send to A when B dies.

## Part 2: distributed Erlang

In a second terminal start a second `iex` REPL like this:

Starts `iex` like this:

```
iex --name node2@127.0.0.1 -S mix
```

In terminal 2, check that the communication between the two nodes is established:

```
iex(node2@127.0.0.1)5> node1 = :"node1@127.0.0.1"
:"node1@127.0.0.1"
iex(node2@127.0.0.1)6> Node.ping(node1)
:pong
```

If the node is NOT reachable, `:pang` is returned instead.

In terminal 2, let's register the process of the REPL with name and then listen
to incoming messages:

```
iex(node2@127.0.0.1)1> Process.register(self(), :repl_node2)
true
iex(node2@127.0.0.1)2> receive do
...(node2@127.0.0.1)2> msg -> IO.inspect(msg, label: "Received")
...(node2@127.0.0.1)2> end
```

In terminal 1, send a message:

```
iex(node1@127.0.0.1)1> send({:repl_node2, :"node2@127.0.0.1"}, {:hello_from, self()})
{:hello_from, #PID<0.156.0>}
iex(node1@127.0.0.1)2> self()
#PID<0.156.0>
```

Here `send` returns the send value and we can see that the local pid of the REPL
starts with 0. Local pids always start with zero.

Now go back to terminal 2, you should see something like that:

```
Received: {:hello_from, #PID<18770.156.0>}
{:hello_from, #PID<18770.156.0>}
```

Here the PID we see is the global one but it still identifies the REPL process
of node1. We have the local pid and the global pid for the same process.

Now starts listening to messages in terminal 1:

```
iex(node1@127.0.0.1)3> receive do
...(node1@127.0.0.1)3> msg -> IO.inspect(msg, label: "Received")
...(node1@127.0.0.1)3> end
```

and sends a message from node2 to node1:

```
iex(node2@127.0.0.1)3> repl_node1_pid = :erlang.list_to_pid('<18770.156.0>')
#PID<18770.156.0>
iex(node2@127.0.0.1)4> send(repl_node1_pid, {:hello_back, 42})
{:hello_back, 42}
```

Now check that the message is received in node1.

We can not only send messages between nodes but also execute arbitrary code.
This is why keeping the `~/.erlang.cookie` file secret is very important.

```
iex(node2@127.0.0.1)5> Node.spawn(:"node1@127.0.0.1", fn -> IO.inspect(self(), label: "pid") end)
#PID<18770.172.0>
pid: #PID<0.172.0>
```

We can see that the global pid listed above starts with the same number as the
one for the REPL process of node1, this shows that the `IO.inspect` code is
executed on node1.

Finally, we can also send any values, inclusive functions!

In terminal 2:

```
iex(node2@127.0.0.1)3> receive do
...(node2@127.0.0.1)3> msg -> IO.inspect(msg.(100), label: "result")
...(node2@127.0.0.1)3> end
```

In terminal 1:

```
iex(node1@127.0.0.1)14> send({:repl_node2, :"node2@127.0.0.1"}, add_42)
#Function<44.65746770/1 in :erl_eval.expr/5>
```

In terminal 2:

```
result: 142
142
```

We have executed in node2 a function sent from node1! This shows the power and
the flexibility of Elixir/Erlang.

In practice we almost never use such the low-level functions such as `send` and
`Node.spawn` but built our application in top of GenServers.

# Open questions

Maybe you know the old [CORBA RPC
technology](https://en.wikipedia.org/wiki/Common_Object_Request_Broker_Architecture)
or a more modern one like gRPC, what make them different to Distributed Erlang?
Why is it possible to have the same interface when sending message locally or on
a node?

One [fallacy of distributed
computing](https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing) is
"The network is reliable". Do you have a guess on how does Elixir/Erlang deal
with it? We will learn more about it in the next section of the tapas.

# Tips

Ask the instructors if you don't understand something or are blocked.

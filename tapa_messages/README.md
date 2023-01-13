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

An Elixir/Erlang system is highly observable and introspectable, we can see that the message queue
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
iex(node1@127.0.0.1)33> pid = TapaMessages.start_message_receiver_2()
#PID<0.252.0>
iex(node1@127.0.0.1)34> send(pid, :some_message)
:some_message
iex(node1@127.0.0.1)35> Process.alive?(pid)
true
iex(node1@127.0.0.1)36> Process.info(pid) |> Keyword.get(:message_queue_len)
1
iex(node1@127.0.0.1)37> send(pid, :some_message_2)
:some_message_2
iex(node1@127.0.0.1)38> Process.info(pid) |> Keyword.get(:message_queue_len)
2
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
error and both processes being linked.

The `Received: {:EXIT, #PID<0.351.0>, :some_error}` output shows us that the
communication for the lifecycle of processes happen also with messages (also
called signals).

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
Node.ping
```

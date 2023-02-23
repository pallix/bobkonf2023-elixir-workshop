# Tapa introspection

## Goal

Explore some of the main tools Elixir/Erlang provides to debug, introspect and
understand how a system behaves.

This tapa reuses the code of `tapa_observer`. So all the following commands must
be executed in the `tapa_observer`:


In terminal 1 starts the application:

```
iex --name tapa_observer@127.0.0.1 -S mix
```

In terminal 2 puts some load in the application:


```
mix register_random_trees 4 100
```

Since terminal 1 is used to display the logs, we will use a new remote `iex` connection
to execute the introspection commands.

In terminal 3:

```
iex --remsh tapa_observer@127.0.0.1 --name debugging@127.0.0.1
```

What can we do to understand our system? A *lot*.

We can see how much memory is used by our application:

```
:erlang.memory()
```

about the garbage collection with `:erlang.system_info(:garbage_collection)` etc.

We can list all running processes:

```
Process.list()
```

There are so many processes running (the ones from our application, the one from
the libraries and the one from Erlang) that the output is truncated.

We can either do:

```
Process.list() |> inspect(limit: :infinity)
```

or configure it at the `iex` level:

```
IEx.configure(inspect: [limit: :infinity])
```

We can list registered process (the ones with a name):

```
Process.registered()
```


We can get information about any process for example:

```
Process.info(Process.whereis(TapaObserver.Store))
```

Now write a one-liner that shows the top 5 processes having the most fulled
message queues. Use the `Enum.sort_by` function for help.

We can trace a process:

```
:sys.trace(TapaObserver.AuditLog, true)
```

The outputs will be in terminal 1. Once you are finished tracing a process:

```
:sys.trace(TapaObserver.AuditLog, false)
```

With the above command we traces all GenServer calls but we can even trace the
private functions with the Erlang `dbg` (debug) module.

```
:dbg.tracer()  # starts a tracer process
:dbg.p(:all, :c) # for all calls
:dbg.tpl(TapaObserver.AuditLog, :_, []) # specify a module
```

You should see something like that in terminal 1, among all the logs:

```
(<0.246.0>) call 'Elixir.TapaObserver.AuditLog':handle_call({log_registration,<<"a2b108b0-ae9c-1016-a0dd-482ae3b15636">>},{<0.272.0>,[alias|#Ref<0.4056542570.2492792833.141841>]},[])
(<0.246.0>) call 'Elixir.TapaObserver.AuditLog':store_to_the_blockchain(<<"a2b108b0-ae9c-1016-a0dd-482ae3b15636">>)
(<0.246.0>) call 'Elixir.TapaObserver.AuditLog':waste_electricity_and_pollute(<<"a2b108b0-ae9c-1016-a0dd-482ae3b15636">>)
```

Use

```
:dbg.stop_clear()
```

when you are finished.

Tracing has a small impact on the performance of the system so it's better to
not abuse it.

It's also possible to trace function according to the values of their arguments
thus filtering the traces but this is beyond the scope of the workshop.

While Erlang provides everything needed, the `recon` library makes introspecting
a bit easier and safer (it gives its best to not overload the system with
expensive introspecting calls).

For example with `recon` we can get the top 5 processes in the last 2 seconds
that have the biggest message queues:

```
:recon.proc_window(:message_queue_len, 5, 2_000)
```

Processes consuming the most memory:

```
:recon.proc_count(:memory, 5)
```

Here we trace 10 calls to the `AuditLog` module:

```
:recon_trace.calls({TapaObserver.AuditLog, :_, :return_trace}, 10)
```

Erlang provides also a stepping debugger (executing line of code one by one) but
this is rarely usable in a distributed system: with a breakpoint in the code the
caller of the code will most probably timeout after a few seconds (5 seconds for
a GenServer call by default).

Some useful functions: `:recon.info(pid, :memory)`, `:recon.bin_leak(5)`,
`recon:scheduler_usage(1000)` etc.

## Open Questions

<details>

It's unconventional to inspect a runtime system in production so deeply for most
developers but this is actually rather common in Elixir/Erlang and in Lisps
(Common Lisp, Clojure etc). This allows to gain so much valuable data about what
is happening, we just need to act carefully and not overload the system with
traces or modify its running data.

Listen to this [podcast](https://corecursive.com/lisp-in-space-with-ron-garret/)
to hear a cool story on how a Lisp REPL was used to debug a spacecraft 30
minutes light-hour away from Earth. This would work in Elixir too ;-).

</details>

# TapaObserver

The challenge of this tapa is to find an issue in the running application with
the Observer, as if it was a in production system.

Do not look at the code of this application before reading the instructions below!

## Goal

*Without looking at the code*, find which process is causing latency problems and a bottleneck.

In a terminal start the project with:

```
iex --name tapa_observer@127.0.0.1 -S mix
```

and then type:

```
:observer.start()
```

We use the [Erlang
Observer](https://www.erlang.org/doc/apps/observer/observer_ug.html) to analyze
the running system. While we now starts the Observer locally, it is also
possible to connect to remote nodes with it. It does not require the application
to be compiled with any special compilation flags, it's just part of what
Elixir/Erlang offers to introspect the system.

In a second terminal, run a Mix task that simulate registering trees:

```
mix register_random_trees 2 500
```

The first number is number of client running in paralell, the second is how
often each client send a registration.

Start playing with the Observer and see if you can find the processes of the
running application in the UI, and what information you can get from them. Right
click on items and see which further actions are available.

The Mix tasks display the time it takes to register a tree, as `info` if it's fast,
`warning` if it's not fast and `error` if it's slow.

Now quit the mix task with Ctrl-C and restarts it but register more tree simultanously:

```
mix register_random_trees 4 100
```

On my system this shows warnings: the registration process is not fast anymore
under this load. Play with different values until you also see some warnings,
then in the Observer, see if you can observe the load.

Now stops again with Ctrl-C and try to overload the system, for example:


```
mix register_random_trees 8 100
```

You should see some errors in the console, indicating that it takes too much
time to register the trees. If not, try more aggressive values.

Using only the Observer, find where the system degrates under heady load. Which
processes cause a bottleneck and why? There is more to it than just the
intensive usage of the CPUs. Write down your assumption in a text file and then
very it by looking at the code.

## Tips

If you are stuck or when you are done read this:

<details>
In the `Processes` tab of the Observer, `reds` means `reductions` is an
indicator of the number of VM operations a process does. You can click on the
columns to sort the processes. If there is a bottleneck, it's probably because a
GenServer is taking too much time to process its messages, how does that show up
in the Observer?

Also: the scaffolding for this project was created with `mix new --sup tapa_observer`.
Do the same when you need to create an application project!

We do not cover Erlang ETS, the fast in-memory storage of Erlang, in this
tutorial, but you will find an example of it in the `Store` GenServer.

</details>

## Open questions

Read this once you are done:

<details>

Assuming we cannot fix the slow `store_to_the_blockchain` function, which cause
the `TreeRegistration` process to accumulate incoming messages, how
could we fix this problem in real life?

If we have enough CPU cores we could try to have multiple instances of the
GenServer on the same machine. This is made very easy since Elixir 1.14 with the
[PartitionSupervisor](https://hexdocs.pm/elixir/1.14.3/PartitionSupervisor.html).

If not we could also scale horizontally and have multiple instances of the
application running on different machines. Do you see other solutions? How do
you solve bottlenecks with the tech stack you are familiar with?

The advantage of Elixir here over another language using gRPC or HTTP for its
services is that by moving from a single-node deployment to a multi-node
deployment the code stays almost the same.

</details>

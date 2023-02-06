# TapaObserver

Do not look at the code of this application before reading the instructions below!

## Goal

### Part 1

*Without looking at the code*, find which process is causing [PROBLEM TO BE DEFINED] every
20 seconds.

In a terminal start the project with:

```
iex --name tapa_observer@127.0.0.1 -S mix
```

and then type:

```
:observer.start()
```

We use the [Erlang
observer](https://www.erlang.org/doc/apps/observer/observer_ug.html) to analyze
the running system. While we now starts the observer locally, it is also
possible to connect to remote nodes with it. It does not require the application
to be compiled with any special compilation flags, it's just part of what
Elixir/Erlang offers to introspect the system.

In a second terminal, run a task that simulate registering numerous trees:

```
mix register_random_trees
```

The code task for the task is located in the `/lib/mix/tasks` folder, creating
an Elixir module there is all what is need to create new task.

### Part 2

## Tips

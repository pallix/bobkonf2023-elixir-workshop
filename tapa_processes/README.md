# TapaProcesses

Processes are *the* core concept of the Erlang runtime. Most of the higher-level
functionalities of Elixir and Erlang are built on top of processes.

## Goal

Let's explore Elixir processes in the REPL!

In a terminal starts `iex` like this:

```
iex -S mix
```

Then type:

```
self()
```

We can see the `pid` of the REPL process.

You can read the documentation of the `self` function like this:

```
h self()
```

Let's start a process that just print its pid and exit:

```
pid = spawn(fn -> IO.inspect(self(), label: "child_pid") end)
```

Is the process alive?

```
Process.alive?(pid)
```

Is the following process alive?
```
pid2 = spawn(fn -> Process.sleep(60_000) end)
```

Sometimes it's useful to get a PID from a string, you can do it like this:

```
:erlang.list_to_pid('<0.191.0>')
```

What happen when the process fails?

```
iex(1)> self()
#PID<0.231.0>
iex(2)> spawn(fn -> 1 / 0 end)
#PID<0.234.0>

12:23:09.424 [error] Process #PID<0.234.0> raised an exception
** (ArithmeticError) bad argument in arithmetic expression
    :erlang./(1, 0)
iex(3)> self()
#PID<0.231.0>
```

or exit because of an error?

```
iex(4)> self()
#PID<0.231.0>
iex(5)> spawn(fn -> Process.exit(self(), :some_error) end)
#PID<0.238.0>
iex(6)> self()
#PID<0.231.0>
```

The parent process is not affected.

Now we use `spawn_link` and the two processes will be linked:

```
iex(8)> self()
#PID<0.231.0>
iex(9)> spawn_link(fn -> Process.exit(self(), :some_error) end)
** (EXIT from #PID<0.231.0>) shell process exited with reason: :some_error

Interactive Elixir (1.13.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> self()
#PID<0.244.0>
```

We see that the error propagated to the parent. `iex` had to restart a new
`REPL` process because the previous one was killed. We will see later in which
scenario this can be useful.

Open a text editor and read the code of the `start_two_children` function
in `lib/tapa_processes.ex`. Then execute the follwing in `iex`:

```
iex(8)> TapaProcesses.start_two_children
```

Can you explain why `IO.puts("This never happens")` is never executed?

What happen when you change the `spawn_link` to `spawn`, reload the module with
`r TapaProcesses.start_two_children` and reexecute the function?

In addition to `spawn` and `spawn_link` there is also `Process.spawn` which is
slightly higher level API. In practice we rarely use these functions but higher
constructions like GenServers.

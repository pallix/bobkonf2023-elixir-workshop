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

Now replace `:some_error` with `:normal` in the code. Reload the code:

```
r TapaProcesses
```

and try again:


```
iex(8)> TapaProcesses.start_two_children
```

What happen?

Now write back `some_error` instead of `normal` and change the `spawn_link` to
`spawn`, reload the module with `r TapaProcesses.start_two_children` and
reexecute the function. What happen?

In addition to `spawn` and `spawn_link` there is also `Process.spawn` which is
slightly higher level API. In practice we rarely use these functions but higher
constructions like GenServers. However it's very important to understand how
linking works. By linking or not linking processes together, we communicate and
enforce the way processes may rely on each other to achieve their work.

Links are always bidirectional, if process A and B are linked, we now that a
failure in B would prevent A to work correctly (and vice-versa) and/or that what
is computed by B can only be used by A. We make it clear that there is a
dependency relationship that should be enforced in case of failure, any failure
in A will make B stop (and vice-versa). This is specially important when using
supervisors (which we see later), in case of a failure it ensures both A and B
will be restarted together, ensuring the system will be in a consistent state.

# Tips

Remember that `'Erlang string'` is the Erlang syntax for strings whereas the `"Elixir string"` is for Elixir.

Processes are not operating systems processes, they are much lighter and less
expensive (no fork in the OS kernel).

Don't just look at the first page on Google when searching the Erlang
documentation, often older version of the documentation get better indexed than
newer so check you are reading the latest version.

# Open questions

How many processes can you create on a machine? Does it depend only of the
hardware? What does the
[doc](https://www.erlang.org/doc/efficiency_guide/advanced.html) say?

Can you interrupt light processes in your language of choice? If there is a
scheduler is it preemptive or cooperative?

The Elixir scheduler is preemptive. Go routines, for example, are [partially
preemptive](https://www.ardanlabs.com/blog/2018/08/scheduling-in-go-part2.html):
they are mostly cooperative with some preemption points. It's thus not possible
to interrupt a Go routine from another one without implementing an interruption
mechanism oneself.

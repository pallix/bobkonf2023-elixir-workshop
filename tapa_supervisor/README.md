# TapaSupervisor

## Goal

Better understand the different restart strategies of the supervisors.

Choosing the supervisors restart strategies requires experience and thinking
deeply about the mode of failures of our application. While the `one_for_one`
strategy is the simplest and the most used, it is not always the one we need.

Suppose for example we want to create a report and analyze how long it takes on
average between the observation of a tree being excessively dry and the same
tree being watered or how long it takes for a watered tree to become dry again.
We could create a `Reporting` GenServer that does such calculation and aggregates
statistics when it receives the message `{:tree_excessively_dry, tree_uuid}` and
`{:tree_watered, tree_uuid}`.

Suppose now than the `{:excessively_dry, tree_uuid}` message is sent by our
`DrynessNotifier` GenServer and that the `{:tree_watered, tree_uuid}` message is
sent by some code from a graphical UI. The messages could be send in any order.
Thus within the `Reporting` GenServer we would accumulate stats about watered
trees. Now suppose that for some unseen reason `DrynessNotifier` crashes, this
mean we would miss some `{:excessively_dry, tree_uuid}` messages during the
crash. It might be better/easier in this case to restart `Reporting` with fresh
stats.

The example is contrived because of the format of the workshop but the core idea
is: we have identified some dependency in the failure modes of our processes. In
our case when `DrynessNotifier` crashes, it would be better also to restart
`Reporting`.

Your goal is to modify the application supervisor tree so that when
`DrynessNotifier` crashes, `Reporting` is also restarted.

Test manually your code with the Observer (`:observer.start` in iex after `iex
-S mix`):

Note the pids of the `DrynessNotifier` and `Reporting` processes, kill the
`DrynessNotifier` process (with right-click) and see if the `Reporting`
processes was restarted. Adjust the refresh interval of the Observer in
View/Refresh interval menu before.

If the code was for production, we could also test the restart with code (using
`Process.exit`, `Process.monitor`, `Supervisor.which_children`, etc).

## Tips

See the different strategies at:

https://hexdocs.pm/elixir/1.14.3/Supervisor.html#module-strategies

We can add a second supervisor to the main supervisor children either by
creating a supervisor module in an extra file and adding to the list of children
(similarly to the way we added the GenServers) or by just specifying its child
specification like this:

```
%{
      id: Something.Something,
      start:
        {Supervisor, :start_link,
         [
           list_of_children_specs,
           [strategy: :some_strategy]
         ]}
}
```

## Open Questions

<details>
What's the advantage of having supervisors and restart strategies when either the
operating system (with systemd on Linux) or the distributed environment
(kubernetes for example) can restart the application?
</details>

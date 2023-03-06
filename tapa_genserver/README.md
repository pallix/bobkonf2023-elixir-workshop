# TapaGenserver

## Goal

Implement the missing code of the `TreeStore` GenServer.

Then implement the missing code of the `DrynessNotifier` GenServer.

You can verify that your implementation is correct by running `mix test`.

## Tips

If you use `Enum.map` but with the purpose of doing side-effects inside the
mapping function, consider `Enum.each` instead. It makes the intention clearer.

Look at the existing code for examples of creating and invoking GenServers.

## Open Questions

Once you are finished, read this:

<details>

The `EmailServer` GenServer does execute only one function and accepts only one
message. Assuming it would really send email, why is it better to have a
GenServer and not just a function in a module?

Technically `TreeStore` could be an Agent but for the purpose of the tutorial
it's better to have it as a GenServer, to give an example of a simple GenServer.
Agents are beyond the scope of this tutorial and are used to share a common
state between processes. You can see them as GenServers where the only thing you
can do on them is change and query their state. Internally Agents are
implemented with GenServers...

</details>

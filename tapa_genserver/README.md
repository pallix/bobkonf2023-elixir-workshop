# TapaGenserver

## Goal

Implement the missing code of the `TreeStore` GenServer.

Then implement the missing code of the `DrynessNotifier` GenServer.

You can verify that your implementation is correct by running `mix test`.

## Open Questions

Once you are finished, read this:

<details>

The `EmailServer` GenServer does execute only one function and accepts only one
message. Assuming it would really send email, why is it better to have a
GenServer and not just a function in a module?

Technically `TreeStore` could be an Agent but for the purpose of the tutorial
it's better to have it as a GenServer, to give an example of a simple
GenServer.

</details>

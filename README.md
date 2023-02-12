# Building highly available systems with Elixir: an introduction

We have all seen computer systems failing, sometimes in a mundane way, sometimes
in a catastrophic way. How can we reduce the probability of such failures to
happen? What makes a system fault tolerant?

In this tutorial, we will explore how Elixir answers these questions and what
makes it particularly well-suited to build highly available systems. We will
provide a quick introduction to the language and its runtime, the Erlang VM.

Participants will then be invited to work on a series of tapas. Tapas are small
projects with a challenge to be solved meant to introduce and illustrate some
fundamental aspects of Elixir and its runtime.

## Before the workshop

Follow the instructions at [BEFORE_WORKSHOP.md](BEFORE_WORKSHOP.md) to setup
your system for the workshop.

## During the workshop

We will present shortly Elixir and its runtime and then you can start tasting
the following tapas. Try the tapas in the order suggested but if you feel
adventurous, you can pick and choose.

The tapas are loosely connected through a common theme: sponsorship and caring
for (physical) trees. The Elixir building blocks we will explore could be used
to build a system helping to organize a community taking care of some trees.

## Tapas

### Basics of the language

Keywords: immutable datastructures, map, structs, list, enumerables, pattern matching, guards, iex

- [Tapa datastructures](./tapa_datastructures/README.md)
- [Tapa enumerables](./tapa_enumerables/README.md)

### Processes, message passing, nodes

Keywords: processes, messages, links, monitor, distributed erlang, trap exit

- [Tapa processes](./tapa_processes/README.md)
- [Tapa messages](./tapa_messages/README.md)

### Generic servers and supervision

Keywords: genserver, supervisor, tasks, monitoring, introspection, debugging

- [Tapa genserver](./tapa_genserver/README.md)
- [Tapa observer](./tapa_observer/README.md)
- [Tapa supervisor]()
- [Tapa introspection]() [sys.get_state, process info, trace flag, dbg, recon]

### Metaprogramming (optional)

Keywords: syntactic macros

- [Tapa macro]()

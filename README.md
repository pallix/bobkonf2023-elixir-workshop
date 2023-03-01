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

If for some reasons you did not manage to set up your system, use the GitPod web
environment here:

https://gitpod.io/#/github.com/pallix/bobkonf2023-elixir-workshop

This will allow you to do most of the tapas except `tapa_observer` and
`tapa_supervisor`.

## During the workshop

We will present shortly Elixir and its runtime and then you can start tasting
the following tapas. Try the tapas in the order suggested but if you feel
adventurous, you can pick and choose.

The tapas are loosely connected through a common theme: sponsorship and caring
for (physical) trees. The Elixir building blocks we will explore could be used
to build a system helping to organize a community taking care of some trees.

## Tapas

### Basics of the language (optional)

Keywords: immutable datastructures, map, structs, list, enumerables, pattern matching, guards, iex

- [Tapa datastructures](./tapa_datastructures/README.md)
- [Tapa enumerables](./tapa_enumerables/README.md)

### Processes, message passing, nodes

Keywords: processes, messages, links, monitor, distributed erlang, trap exit

- [Tapa processes](./tapa_processes/README.md)
- [Tapa messages](./tapa_messages/README.md)

### Generic servers and supervision

Keywords: genserver, supervisor, tasks, introspection, debugging

- [Tapa genserver](./tapa_genserver/README.md)
- [Tapa observer](./tapa_observer/README.md)
- [Tapa supervisor](./tapa_supervisor/README.md)
- [Tapa introspection](./tapa_introspection/README.md)

## Beyond the workshop

If you enjoyed the workshop, you can learn more of Elixir by following the official getting started guide:

https://elixir-lang.org/getting-started/introduction.html

Some mentioned subjects we explore with less depth (general features), some with
more depth (distributed aspects, debugging and introspection).

You can then start working on a small project or if you feel you need to learn more first, have a look at:

https://elixir-lang.org/learning.html

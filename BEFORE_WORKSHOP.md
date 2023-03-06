## Before the workshop

### Cloning the repository

Clone this repository on your laptop:

```
git clone https://github.com/pallix/bobkonf2023-elixir-workshop.git
```

### Installing Elixir (mandatory)

Make sure you have Elixir 1.14 or superior installed. You can find
[instructions](https://elixir-lang.org/install.html#distributions) on the
official website.

We assume the participants are either using Linux or MacOS. While the tutorial
probably works on Windows, we did not test on it. If you are using Windows, you might
want to install Elixir in a Linux virtual machine (virtualbox, vmware etc).

If your operating system does not provide Elixir 1.14 or superior, you can run
the [docker image](https://elixir-lang.org/install.html#docker) or install the
[Nix package manager](https://elixir-lang.org/install.html#docker). With Nix you
can get a shell with a recent Elixir version with the following command:
`nix-shell -p beam.packages.erlangR25.elixir_1_14`.

### Verifying the Elixir installation (mandatory)

Check your Elixir version with the following command:

```
elixir --version
```

You should see an output similar to this one:

```
Erlang/OTP 25 [erts-13.1.4] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit:ns]

Elixir 1.14.3 (compiled with Erlang/OTP 25)
```

Create a test project with the following command:

```
mix new test_project
```

You should see this output

```
* creating README.md
* creating .formatter.exs
* creating .gitignore
* creating mix.exs
* creating lib
* creating lib/test_project.ex
* creating test
* creating test/test_helper.exs
* creating test/test_project_test.exs

Your Mix project was created successfully.
You can use "mix" to compile it, test it, and more:

    cd test_project
    mix test

Run "mix help" for more commands.
```

The execute the mentioned instructions:

```
cd test_project
mix test
```

You should see

```
Compiling 1 file (.ex)
Generated test_project app
..

Finished in 0.01 seconds (0.00s async, 0.01s sync)
1 doctest, 1 test, 0 failures

[...]
```

### Setting up your editor / IDE (mandatory)

Set up your editor or IDE to work with Elixir.
Elixir has support for the [language server protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol).

### Watching a cool talk (optional)

The [Soul of Erlang and Elixir](https://www.youtube.com/watch?v=JvBT4XBdoUE) by
Sasa Juric is a very interesting talk and, if you have time, makes a perfect
introduction to the workshop.

### Starting the first two tapas (recommanded)

We have lot of awesome workshop material and a limited amount time so we encourage
the participants to do the first two tapas at home before the workshop so that we
can concentrate on the fault-tolerant aspects of Elixir!

- [Tapa datastructures](./tapa_datastructures/README.md)
- [Tapa enumerables](./tapa_enumerables/README.md)

The exercises are relatively simple and can be solved with the helped of their
README and some googling. If you don't have time, don't worry we will review
them quickly together at the start of the workshop.

### Finishing

Well done, you are ready for the workshop!

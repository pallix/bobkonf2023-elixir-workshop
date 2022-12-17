## Before the workshop

### Cloning the repository

Clone this repository on your laptop:

```
git clone https://github.com/pallix/bobkonf2023-elixir-workshop.git
```

### Installing Elixir

Make sure you have Elixir 1.13 or superior installed. You can find
[instructions](https://elixir-lang.org/install.html#distributions) on the
official website.

We assume the participants are either using Linux or MacOS. While the tutorial
probably works on Windows, we did not test on it. If you are using Windows, you might
want to install Elixir in a Linux virtual machine (virtualbox, vmware etc).

If your operating system does not provide Elixir 1.13 or superior, you can run
the [docker image](https://elixir-lang.org/install.html#docker) or install the
[Nix package manager](https://elixir-lang.org/install.html#docker). With Nix you
can get a shell with a recent Elixir version with the following command:
`nix-shell -p elixir`.

### Verifying the Elixir installation

Check your Elixir version with the following command:

```
elixir --version
```

You should see an output similar to this one:

```
Erlang/OTP 24 [erts-12.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit]

Elixir 1.13.4 (compiled with Erlang/OTP 24)
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

Well done, you are ready for the workshop!

### Watching a cool talk (optional)

The [Soul of Erlang and Elixir](https://www.youtube.com/watch?v=JvBT4XBdoUE) by
Sasa Juric is a very interesting talk and, if you have time, makes a perfect
introduction to the workshop.

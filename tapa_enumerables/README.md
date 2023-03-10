# TapaEnumerables

## Before starting

Fetch the dependencies of the project with:

```
mix deps.get
```

## Goal

### Part one

Run the tests with this command:

```
mix test
```

Fix the failing tests!

You can run one module test only with (for example):

`mix test test/tapa_enumerables/location_test.exs`

or only one test with (for example):

`mix test test/tapa_enumerables/location_test.exs:10`

Read this when you are finished:

<details>

As an extra exercise, if you have time, do this: if you implemented
`average_moisture(trees)` with `Enum.sum` and `Enum.count`, make a second
implementation of the function with `Enum.reduce` and vice versa.

</details>

### Tips

The syntax for anonymous functions:

a) like this

```
Enum.map([1, 2, 3], fn el -> doSomething(el, 42) end)
```

b) or like this:


```
Enum.map([1, 2, 3], &doSomething(&1, 42))
```

c) or like this:

```
Enum.map([1, 2, 3], &doAnotherThing/1)
```

Here `doAnotherThing/1` refers to the `doAnotherThing` function accepting one
argument.


Use the [Geocalc.distance_between](https://github.com/yltsrc/geocalc) to
calculate the distance between two locations. You will need also the function in
the [Enum module](`https://hexdocs.pm/elixir/1.14.2/Enum.html`).

### Part two

Playing with `maps` and discovering the `iex` REPL.

Starts iex for the project like this:

`iex -S mix`

Be sure to be in the `tapa_enumerables` directory.

Alias the `Tree` module:

```
iex(1)> alias TapaEnumerables.Tree
```

Now creates a tree in the REPL:

```
iex(2)> tree = %Tree{uuid: UUID.uuid1(), latitude: 0, longitude: 0, moisture: 50}
```

We can use the field of the structure to access it:

```
iex(6)> tree.moisture
50
```

All function in the `Map` module are also available for structures:

```
iex(7)> Map.get(tree, :moisture)
50
iex(8)> Map.get(tree, :this_field_does_not_exists)
nil
```

Type `tree.` in the REPL and enter the tabulation key, you should see:

```
iex(10)> tree.
__struct__    latitude      longitude     moisture      specie
uuid
```

We see all fields declared in the structure plus `__struct__`.

Its value is the module of the structure:

```
iex(10)> tree.__struct__
TapaEnumerables.Tree
```

Creates a copy of the tree where the `__struct__` field is deleted:

```
iex(13)> tree2 = Map.delete(tree, :__struct__)
```

You can now see with the [is_struct](https://hexdocs.pm/elixir/1.12/Kernel.html#is_struct/1) function that `tree2` is not a struct anymore.

There is a `Map.from_struct` function in the `Map` module. It converts from a
struct to a plain map. How do you think it is implemented :-)? Check its [source](https://github.com/elixir-lang/elixir/blob/v1.14.2/lib/elixir/lib/map.ex#L999). Remember that modules names are just atoms, so `when is_atom(struct)` is checking if the parameter is a module.

This implementation of `from_struct` is obviously simple but in general it is
true the source code of Elixir can be read easily. Did you see the `</>` symbols
in the [documentation of the
API](https://hexdocs.pm/elixir/1.12/Kernel.html#is_struct/1)? It links to the
source code of each function.

Maps are enumerable too, type this for example:

```
iex(29)> tree |> Map.from_struct() |> Enum.each(&IO.inspect/1)
```

What happened?

But structs do not implement the Enumerable protocol (a protocol is a bit like
an interface in other languages) so this will fail: `Enum.each(tree,
&IO.inspect/1)`. See the discussion on the [Elixir
forum](https://elixirforum.com/t/access-behaviour-on-structs/11003/2) if you
want to understand why or just skip to the next tapa, it's not really important
for this workshop!

If you make some modification to a module, you can reload it in `iex` like this:

```
iex(20)> r TapaEnumerables.Tree
```

## Open questions

Once you are finished with this tapa, read this:

<details>

We tasted `filter`, `map` and `reduce`. There are many other functions in the
`Enum` module but these three are the most used.

When using `Enum.map` twice on a collection, for example with the pipe (`|>`)
operator, we iterate twice on the elements of the list. The performance will be
poor if we have a lot of operations or a lot of elements. We could use only one
call to `map` and do the two operations inside it but what we gain in efficiency
we then loose in composability. The `Stream` modules allows to calculate
elements in a lazy way, solving this problem. It also allows to consume some data
on demand, for example if we need to read a huge file and not load everything at
once in memory (see https://hexdocs.pm/elixir/1.14.2/File.html#stream!/3).

All Elixir collections implements the Enumerable protocol so the functions in
the `Enum` module are valid for all of them, not only for lists!

Do your language of choice offers a way to unify collections under a common
interface? Does it offer streams as part of the standard library or with an
external library?

</details>

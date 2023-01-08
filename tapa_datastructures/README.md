# TapaDatastructures

A tapa showing the basic usage the most common datastructures.

## Before starting

Fetch the dependencies of the project with:

```
mix deps.get
```

## Goal

Have all the test green. Run the tests with this command:

```
mix test
```

You will see the tests are failing. Implement the functions in the `Tree` module
until all the tests pass.

## Tips

You can use the `UUID.uuid1()` function to generate random identifiers for the trees.

Stuck? Here some other tips:

<details>

Refer to the documentation on [guards](https://hexdocs.pm/elixir/guards.html)

You can pattern-match a structure in a function like this:

```
def my_function(%my_struct{value: 1}) do
 # do something
end

def my_function(%my_struct{value: 2}) do
 # do something else
end
```

Pattern-matching works also on lists, maps, integer, etc.

If you are curious, check the documentation about the [Erlang `rand:uniform`
](https://www.erlang.org/doc/man/rand.html#uniform-0) function.

</details>

## Open questions

Once you are finished with this tapa, read this:

<details>

You have probably notice that Elixir can identify a missing key in a struct at
compile time. This is one advantage of using structures over maps. Maps on the
other end are more flexible since they can have all possible keys and do not
require to be declared in advance, we will explore them in the next tapa.

The update syntax: `%MyRecord{record_variable | field: new_value}` prevents us from updating a
field that does not exist. This is checked at compile time for structs and at runtime for maps.

We often categorize languages as dynamically or statically typed, but even in
these categories, some languages offer more guarantees than other. If you have
used a dynamically language recently, what kind of guarantees are provided by it
at compile time?

</details>

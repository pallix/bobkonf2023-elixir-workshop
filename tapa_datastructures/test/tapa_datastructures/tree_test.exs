defmodule TapaDatastructures.TreeTest do
  use ExUnit.Case

  import TapaDatastructures.Tree

  alias TapaDatastructures.Tree

  test "create a random tree struct" do
    tree = create_random_tree()
    assert tree.latitude >= -90 and tree.latitude <= 90
    assert tree.longitude >= -180 and tree.longitude <= 180
    assert tree.moisture >= 0 and tree.moisture <= 100
    assert tree.specie in species()
    refute is_nil(tree.uuid)
  end

  # Note that the test above is not deterministic because
  # of the random data generated but making it deterministic
  # is beyond the scope of the workshop

  test "calculate moisture level" do
    # use pattern-matching on the argument of the function and guards to
    # implement the moisture_level function, use multiple function bodies. This
    # technique is often cleaner that hiding the code branches behind if or cond
    # statements and makes the code easier to read.

    tree = %Tree{latitude: 0, longitude: 0, moisture: 5, specie: :maple, uuid: UUID.uuid1()}

    assert moisture_level(tree) == :excessively_dry
    assert moisture_level(%{tree | moisture: 50}) == :normal
    assert moisture_level(%{tree | moisture: 80}) == :excessively_wet
  end

end

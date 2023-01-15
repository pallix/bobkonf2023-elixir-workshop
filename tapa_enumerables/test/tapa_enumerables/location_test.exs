defmodule TapaEnumerables.LocationTest do
  use ExUnit.Case

  alias TapaEnumerables.Location
  alias TapaEnumerables.Tree
  alias Uniq.UUID

  @bobkonf_location {52.5760184, 13.3517038}

  test "finding trees near a location, default to within 100 meters" do
    uuid_tree1 = UUID.uuid1()
    uuid_tree2 = UUID.uuid1()

    trees = [
      %Tree{
        uuid: uuid_tree1,
        latitude: 52.5751940,
        longitude: 13.3520287,
        moisture: :unknown,
        specie: :unknown,
      },
      %Tree{
        uuid: uuid_tree2,
        latitude:  52.5785785,
        longitude: 13.3330421,
        moisture: :unknown,
        specie: :unknown
      }
    ]

    trees_found = Location.trees_nearby(trees, @bobkonf_location)
    assert Enum.count(trees_found) == 1

    [tree_found] = trees_found
    assert tree_found.uuid == uuid_tree1
  end

  test "finding trees near a location" do
    uuid_tree1 = UUID.uuid1()
    uuid_tree2 = UUID.uuid1()

    trees = [
      %Tree{
        uuid: uuid_tree1,
        latitude: 52.5751940,
        longitude: 13.3520287,
        moisture: :unknown,
        specie: :unknown,
      },
      %Tree{
        uuid: uuid_tree2,
        latitude:  52.5785785,
        longitude: 13.3330421,
        moisture: :unknown,
        specie: :unknown
      }
    ]

    trees_found = Location.trees_nearby(trees, @bobkonf_location, 2_000)
    assert Enum.count(trees_found) == 2
  end

  test "get all locations of a list of trees" do
    uuid_tree1 = UUID.uuid1()
    uuid_tree2 = UUID.uuid1()
    # here we use multiple pattern-matching:
    location1 = {latitude_1, longitude_1} = {52.5751940, 13.3520287}
    location2 = {latitude_2, longitude_2} = {52.5785785, 13.3330421}

    trees = [
      %Tree{
        uuid: uuid_tree1,
        latitude: latitude_1,
        longitude: longitude_1,
        moisture: :unknown,
        specie: :unknown,
      },
      %Tree{
        uuid: uuid_tree2,
        latitude:  latitude_2,
        longitude: longitude_2,
        moisture: :unknown,
        specie: :unknown
      }
    ]

    assert Location.locations(trees) == [location1, location2]
  end
end

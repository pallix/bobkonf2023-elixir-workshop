defmodule TapaEnumerables.MoistureTest do
  use ExUnit.Case

  alias TapaEnumerables.Moisture
  alias TapaEnumerables.Tree

  describe "the average moisture of a list of trees" do
    test "is :unknown is the list is empty" do
      assert Moisture.average_moisture([]) == :unknown
    end

    test "ignores :unknown moistures values" do
      trees = [
        %Tree{
          uuid: UUID.uuid1(),
          latitude: 52.5751940,
          longitude: 13.3520287,
          moisture: :unknown,
          specie: :unknown
        }
      ]

      assert Moisture.average_moisture(trees) == :unknown
    end

    test "is the average of the moisture field that are floats" do
      trees = [
        %Tree{
          uuid: UUID.uuid1(),
          latitude: 52.5751940,
          longitude: 13.3520287,
          moisture: :unknown,
          specie: :unknown
        },
        %Tree{
          uuid: UUID.uuid1(),
          latitude: 52.5785785,
          longitude: 13.3330421,
          moisture: 99.2,
          specie: :unknown
        },
        %Tree{
          uuid: UUID.uuid1(),
          latitude: 62.5785785,
          longitude: 23.3330421,
          moisture: 49.0,
          specie: :unknown
        }
      ]

      assert_in_delta Moisture.average_moisture(trees), 74.1, 0.0001
    end
  end
end

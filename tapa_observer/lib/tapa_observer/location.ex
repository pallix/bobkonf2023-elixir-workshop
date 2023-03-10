defmodule TapaObserver.Location do
  @moduledoc "Spacial operations to find and locate trees."

  @doc """
  Returns all trees that are within `distance` of `location`.

  - `distance`: the distance in meters, by default 100.
  """
  def trees_nearby(trees, location, distance \\ 100) do
    Enum.filter(trees, fn tree ->
      Geocalc.distance_between(location, {tree.latitude, tree.longitude}) <= distance
    end)
  end

  def locations(trees) do
    Enum.map(trees, fn tree -> {tree.latitude, tree.longitude} end)
  end
end

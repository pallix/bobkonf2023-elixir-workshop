defmodule TapaObserver.Moisture do
  @moduledoc "Information about the moisture of the soil."

  @doc "Returns the average moisture of a list of tree"
  def average_moisture(trees) do
      trees
      |> Enum.reject(&(&1.moisture == :unknown))
      |> calculate_average_moisture()
  end

  # calculation on trees which a moisture field which is not :unknown
  defp calculate_average_moisture([]) do
    :unknown
  end

  defp calculate_average_moisture(trees) do
    {sum, count}
    = trees
    |> Enum.reduce({0, 0}, fn tree, {sum, count} ->
      {sum + tree.moisture, count + 1}
    end)

    sum / count
  end

  # The code above we iterate twice on the list, once for reject and once for reduce.
  # This is ok but only when lists are small of course.
  # One alternative is to filter for :unknown within the reduce but it makes the code
  # less readable.
end

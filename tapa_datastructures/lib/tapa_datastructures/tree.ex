defmodule TapaDatastructures.Tree do
  @moduledoc "Represents a physical tree and the operations on it"

  alias TapaDatastructures.Tree

  @enforce_keys [:uuid, :latitude, :longitude, :moisture]

  @doc """
  Representation of a tree.

  - `id`: an UUID
  - `latitude`: a float between -90.0 and 90.0
  - `longitude`: a float between -180.0 and 180.0
  - `moisture`: current moisture of the soil where the tree is, between 0 (completely dry) and 100 (flooded).
  - `specie`: the scientific name in Latin of the type of tree
  """
  defstruct uuid: nil,
            latitude: nil,
            longitude: nil,
            moisture: :unknown,
            specie: nil

  @species [
    :quercus, # oak
    :tilia,  # linden
    :acer,  # maple
    :platanus, # plane
    :aesculus, # chestnut
    :unknown
  ]

  @doc "Creates a tree with random attributes."
  def create_random_tree() do
    # TODO: implement this
    %Tree{
      uuid: nil,
      latitude: nil,
      longitude: nil,
      specie: nil,
      moisture: nil
    }
  end

  # this is also a valid syntax for functions having only one line of code!
  def species, do: @species

  @doc """
  Returns an atom representing the moisture level.
  """
  # TODO, implement this with pattern matching and guards
  def moisture_level(tree) do
  end

  defp random_latitude() do
    :rand.uniform() * 180 - 90
  end

  defp random_longitude() do
    :rand.uniform() * 360 - 180
  end

  defp random_specie() do
    Enum.random(@species)
  end
end

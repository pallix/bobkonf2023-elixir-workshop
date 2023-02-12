defmodule TapaGenserver.Tree do
  @moduledoc "Represents a physical tree and the operations on it"

  alias TapaGenserver.Tree

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
    %Tree{
      uuid: Uniq.UUID.uuid1(),
      latitude: random_latitude(),
      longitude: random_longitude(),
      moisture: random_moisture(),
      specie: random_specie()
    }
  end

  # this is also a valid syntax for functions having only one line of code!
  def species, do: @species

  @doc """
  Returns an atom representing the moisture level.
  """
  def moisture_level(%Tree{moisture: :unknown}) do
    :unknown
  end

  def moisture_level(%Tree{moisture: moisture}) when moisture < 20 do
    :excessively_dry
  end

  def moisture_level(%Tree{moisture: moisture}) when moisture >= 20 and moisture < 80 do
    :normal
  end

  def moisture_level(%Tree{moisture: moisture}) when moisture >= 80 do
    :excessively_wet
  end

  defp random_moisture do
    :rand.uniform(101) - 1
  end

  defp random_latitude do
    :rand.uniform() * 180 - 90
  end

  defp random_longitude do
    :rand.uniform() * 360 - 180
  end

  defp random_specie do
    Enum.random(@species)
  end
end

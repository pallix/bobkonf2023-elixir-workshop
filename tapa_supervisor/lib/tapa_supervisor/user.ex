defmodule TapaSupervisor.User do
  @moduledoc "Structure reprensenting an user"

  @enforce_keys [:name, :location, :email]

  defstruct name: nil,
            location: nil,
            email: nil
end

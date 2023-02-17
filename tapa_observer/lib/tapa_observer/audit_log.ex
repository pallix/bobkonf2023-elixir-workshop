defmodule TapaObserver.AuditLog do
  @moduledoc "Creates an audit log of registered trees."

  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  #
  # Public API
  #

  def log_registration(tree_uuid) do
    GenServer.call(__MODULE__, {:log_registration, tree_uuid})
  end

  #
  # GenServer callbacks
  #

  def init([]) do
    {:ok, []}
  end

  def handle_call({:log_registration, tree_uuid}, _from, state) do
    store_to_the_blockchain(tree_uuid)
    {:reply, :ok, state}
  end

  #
  # Private functions
  #

  defp store_to_the_blockchain(tree_uuid) do
    waste_electricity_and_pollute(tree_uuid)
  end

  defp waste_electricity_and_pollute(tree_uuid) do
    for _ <- 1..200000 do
      :crypto.hash(:sha3_256, tree_uuid)
    end
  end
end

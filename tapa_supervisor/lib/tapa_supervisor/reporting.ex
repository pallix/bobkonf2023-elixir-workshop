defmodule TapaSupervisor.Reporting do
  @moduledoc "Reporting about how long trees stay dry"

  use GenServer

  def start_link(_options) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  #
  # GenServer callbacks
  #

  def init([]) do
    {:ok, []}
  end

  def handle_call({:tree_excessively_dry, _uuid}, _from, state) do
    # not implemented, we just focus on the supervisor restarts for this tapa
    {:reply, :ok, state}
  end

  def handle_call({:tree_watered, _uuid}, _from, state) do
    # not implemented, we just focus on the supervisor restarts for this tapa
    {:reply, :ok, state}
  end

end

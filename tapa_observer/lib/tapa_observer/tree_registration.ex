defmodule TapaObserver.TreeRegistration do
  @moduledoc "TODO"

  use GenServer

  require Logger

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  def handle_call({:register_tree, tree}, _from, state) do
    Logger.info("Registering tree #{tree.uuid}")
    Process.sleep(200)

    {:reply, :ok, state}
  end
end

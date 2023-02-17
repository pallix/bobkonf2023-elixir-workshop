defmodule TapaObserver.TreeRegistration do
  @moduledoc "Registration of new trees."

  use GenServer

  require Logger

  alias TapaObserver.Store
  alias TapaObserver.AuditLog

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  def handle_call({:register_tree, tree}, _from, state) do
    Logger.info("Registering tree #{tree.uuid}")

    with {:ok, _} <- Store.save(tree),
         :ok <- AuditLog.log_registration(tree.uuid) do
      {:reply, :ok, state}
    else
      err ->
        {:reply, err, state}
    end
  end
end

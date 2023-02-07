defmodule TapaObserver.Store do
  @moduledoc "Store for the registered tree."

  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  #
  # Public API
  #

  def save(tree) do
    GenServer.call(__MODULE__, {:save, tree})
  end

  def load(uuid) do
    GenServer.call(__MODULE__, {:load, uuid})
  end

  #
  # GenServer callbacks
  #

  def init([]) do
    __MODULE__ = :ets.new(__MODULE__, [:named_table, :set, :public])
    {:ok, []}
  end

  def handle_call({:save, tree}, _from, state) do
    res = insert_tree(tree)
    {:reply, res, state}
  end

  def handle_call({:load, uuid}, _from, state) do
    res = load_tree(uuid)
    {:reply, res, state}
  end

  #
  # Private functions
  #

  defp insert_tree(tree) do
    if :ets.insert(__MODULE__, {tree.uuid, tree}) do
      {:ok, tree}
    else
      {:error, :cannot_insert}
    end
  end

  defp load_tree(uuid) do
    case :ets.lookup(__MODULE__, uuid) do
      [] ->
        {:error, :notfound}
      [{_key, tree}] ->
        {:ok, tree}
    end
  end
end

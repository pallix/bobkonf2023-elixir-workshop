defmodule TapaGenserver.TreeStore do
  @moduledoc "Store for the registered trees"

  use GenServer

  alias TapaGenserver.Tree

  #
  # Public API
  #

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  def store(tree) do
    GenServer.call(__MODULE__, {:store, tree})
  end

  def execessively_dry_trees() do
    GenServer.call(__MODULE__, :excessively_dry_trees)
  end

  #
  # GenServer callbacks
  #

  def handle_call({:store, tree}, _from, state) do
    state = [tree | state]
    {:reply, :ok, state}
  end

  def handle_call(:excessively_dry_trees, _from, state) do
    trees = find_excessively_dry_trees(state)
    {:reply, trees, state}
  end

  defp find_excessively_dry_trees(trees) do
    Enum.filter(trees, fn tree -> Tree.moisture_level(tree) == :excessively_dry end)
  end
end

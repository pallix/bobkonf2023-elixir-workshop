defmodule TapaGenserver.TreeStore do
  @moduledoc "Store for the registered trees"

  use GenServer

  # alias TapaGenserver.Tree

  #
  # Public API
  #

  def start_link(options) do
    name = Keyword.get(options, :name, __MODULE__)
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def init([]) do
    {:ok, 42}
  end

  #
  # GenServer callbacks
  #

  def handle_call({:store, _tree}, _from, state) do
    # TODO
    {:reply, :ok, state}
  end

  def handle_call(:excessively_dry_trees, _from, state) do
    # TODO
    {:reply, [], state}
  end
end

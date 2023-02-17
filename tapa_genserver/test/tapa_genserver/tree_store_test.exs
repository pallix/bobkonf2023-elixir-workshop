defmodule TapaGenserver.TreeStoreTest do
  use ExUnit.Case

  alias TapaGenserver.TreeStore
  alias TapaGenserver.Tree
  alias Uniq.UUID

  setup do
    {:ok, tree_store} = start_supervised({TreeStore, [name: TreeStore.Test]})

    [tree_store: tree_store]
  end

  test "returns the dry trees", ctx do
    %{tree_store: tree_store} = ctx
    tree1 = %Tree{uuid: UUID.uuid1(), latitude: 0, longitude: 0, moisture: 1}
    tree2 = %Tree{uuid: UUID.uuid1(), latitude: 1, longitude: 1, moisture: 80}

    :ok = GenServer.call(tree_store, {:store, tree1})
    :ok = GenServer.call(tree_store, {:store, tree2})

    assert GenServer.call(tree_store, :excessively_dry_trees) == [tree1]
  end
end

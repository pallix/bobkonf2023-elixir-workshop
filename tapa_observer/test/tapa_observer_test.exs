defmodule TapaObserverTest do
  use ExUnit.Case
  doctest TapaObserver

  test "greets the world" do
    assert TapaObserver.hello() == :world
  end
end

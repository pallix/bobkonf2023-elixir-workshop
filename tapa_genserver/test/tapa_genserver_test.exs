defmodule TapaGenserverTest do
  use ExUnit.Case
  doctest TapaGenserver

  test "greets the world" do
    assert TapaGenserver.hello() == :world
  end
end

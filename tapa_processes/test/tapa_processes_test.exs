defmodule TapaProcessesTest do
  use ExUnit.Case
  doctest TapaProcesses

  test "greets the world" do
    assert TapaProcesses.hello() == :world
  end
end

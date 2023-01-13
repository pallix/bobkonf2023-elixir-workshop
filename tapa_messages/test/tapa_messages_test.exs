defmodule TapaMessagesTest do
  use ExUnit.Case
  doctest TapaMessages

  test "greets the world" do
    assert TapaMessages.hello() == :world
  end
end

defmodule TapaProcesses do
  @moduledoc """
  Documentation for `TapaProcesses`.
  """

  def start_two_children do
    spawn(fn ->
      IO.inspect("Starting child1")

      spawn_link(fn ->
        IO.inspect(self(), label: "child2")
        IO.puts("Waiting in child2")
        Process.sleep(4_000)
        IO.puts("This never happens")
      end)

      Process.sleep(2_000)
      IO.puts("Exiting in child1")
      Process.exit(self(), :some_error)
    end)
  end
end

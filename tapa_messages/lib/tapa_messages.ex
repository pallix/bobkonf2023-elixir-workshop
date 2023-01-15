defmodule TapaMessages do
  @moduledoc """
  Documentation for `TapaMessages`.
  """

  def start_message_receiver do
    spawn(fn ->
      IO.inspect(self(), label: "receiver_pid")

      receive do
        msg ->
          IO.inspect(msg, label: "Received")
      end
    end)
  end

  def start_message_receiver_2 do
    spawn(fn ->
      receive do
        {:ping, from} ->
          send(from, :pong)

        :show_pid ->
          IO.inspect(self(), label: "pid")
      end
    end)
  end

  def start_two_children do
    spawn(fn ->
      IO.inspect("Starting child1")

      spawn_link(fn ->
        IO.inspect(self(), label: "child2")

        receive do
          msg ->
            IO.inspect(msg, label: "Received")
        end
      end)

      Process.sleep(2_000)
      IO.puts("Exiting in child1")
      Process.exit(self(), :some_error)
    end)
  end

  def start_two_children_trap_exit do
    spawn(fn ->
      IO.inspect("Starting child1")

      spawn_link(fn ->
        Process.flag(:trap_exit, true)
        IO.inspect(self(), label: "child2")

        receive do
          msg ->
            IO.inspect(msg, label: "Received")
            IO.puts("Type: Process.alive?(:erlang.list_to_pid('#{:erlang.pid_to_list(self())}'))")
            Process.sleep(60_000)
        end
      end)

      Process.sleep(2_000)
      IO.puts("Exiting in child1")
      Process.exit(self(), :some_error)
    end)
  end
end

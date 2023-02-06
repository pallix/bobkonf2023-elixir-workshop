defmodule Mix.Tasks.RegisterRandomTrees do
  @moduledoc false

  alias TapaObserver.Tree

  require Logger

  @remote_node :"tapa_observer@127.0.0.1"

  def start_distributed_erlang do
    :net_kernel.start([:"tapa_observer_script@127.0.0.1"])
    :erl_boot_server.start([])
  end

  def run([tasks_count_arg, sleep_time_arg]) do
    start_distributed_erlang()
    IO.puts "running task :-)"
    {:ok, _} = Application.ensure_all_started(:uniq)
    {sleep_time_ms, ""} = Integer.parse(sleep_time_arg)
    {tasks_count, ""} = Integer.parse(tasks_count_arg)
    tasks = Enum.map(1..tasks_count, fn task_counter ->
      Task.async(fn -> loop(task_counter, sleep_time_ms) end)
    end)
    Task.await_many(tasks, :infinity)
  end

  def register_random_tree(task_counter) do
    tree = Tree.create_random_tree()

  {duration_us, result} = :timer.tc(fn ->
      try do
        GenServer.call({TapaObserver.TreeRegistration, @remote_node}, {:register_tree, tree})
      catch :exit, e ->
          e
      end
    end)

    duration_ms = duration_us / 1_000

    case result do
      :ok ->
        Logger.info("Registered #{tree.uuid} in task #{task_counter}")

      {:timeout, _details} ->
        Logger.error("Could not registered #{tree.uuid}: timeout")

      other ->
        Logger.error("Could not registered #{tree.uuid}: #{inspect(other)}")
    end

    cond do
      duration_ms < 300 ->
        Logger.info("Took #{duration_ms}")

      duration_ms >= 300 and duration_ms < 600 ->
        Logger.warning("Took #{duration_ms}")

      duration_ms >= 600 ->
        Logger.error("Took #{duration_ms}")
    end

  rescue
    e ->
      Logger.error("Error #{inspect(e)}")
  end

  def loop(task_counter, sleep_time_ms) do
    register_random_tree(task_counter)
    Process.sleep(sleep_time_ms)
    loop(task_counter, sleep_time_ms)
  end
end

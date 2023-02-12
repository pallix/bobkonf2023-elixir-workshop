defmodule TapaGenserver.DrynessNotifier do
  @moduledoc "TODO"

  use GenServer

  #
  # Public API
  #

  def start_link(options) do
    GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  def init(options) do
    email_notifier = Keyword.get(options, :email_notifier, TapaGenServer.EmailNotifier)
    notify_period = Keyword.get(options, :notify_period, 10_000)

    :timer.send_interval(:notify_users, notify_period)

    {:ok, %{email_notifier: email_notifier}}
  end

  #
  # GenServer callbacks
  #

  def handle_info(:notify_users, state) do
    notify_users()
    {:noreply, state}
  end

  #
  # Private functions
  #

  defp notify_users() do
    # dry_trees = TreeStore.dry_trees()
  end
end

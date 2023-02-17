defmodule TapaGenserver.DrynessNotifier do
  @moduledoc "GenServer notifying users when trees are too dry"

  use GenServer

  require Logger

  #
  # Public API
  #

  def start_link(options) do
    name = Keyword.get(options, :name, __MODULE__)
    GenServer.start_link(__MODULE__, options, name: name)
  end

  def init(options) do
    tree_store = Keyword.get(options, :tree_store, TapaGenserver.TreeStore)
    user_store = Keyword.get(options, :user_store, TapaGenserver.UserStore)
    email_sender = Keyword.get(options, :email_sender, TapaGenserver.EmailSender)
    notify_period = Keyword.get(options, :notify_period, 2_000)

    :timer.send_interval(notify_period, :notify_users)

    {:ok, %{tree_store: tree_store, user_store: user_store, email_sender: email_sender}}
  end

  #
  # GenServer callbacks
  #

  def handle_info(:notify_users, state) do
    notify_users(state)
    {:noreply, state}
  end

  #
  # Private functions
  #

  defp notify_users(state) do
    dry_trees = GenServer.call(state.tree_store, :excessively_dry_trees)
    # TODO: implement the rest!
  end
end

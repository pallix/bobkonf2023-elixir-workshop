defmodule TapaGenserver.UserStore do
  @moduledoc "Store for the registered users"

  use GenServer

  #
  # Public API
  #

  def start_link(options) do
    name = Keyword.get(options, :name, __MODULE__)
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def init([]) do
    {:ok, []}
  end

  def store(user) do
    GenServer.call(__MODULE__, {:store, user})
  end

  #
  # GenServer callbacks
  #

  def handle_call({:store, user}, _from, state) do
    state = [user | state]
    {:reply, :ok, state}
  end

  def handle_call({:users_close_from, location}, _from, state) do
    close_users = users_close_from(state, location)
    {:reply, close_users, state}
  end

  defp users_close_from(users, location) do
    Enum.filter(users, fn user ->
      Geocalc.distance_between(location, user.location) <= 1_000
    end)
  end
end

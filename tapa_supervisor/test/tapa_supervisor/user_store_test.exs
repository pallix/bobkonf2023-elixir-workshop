defmodule TapaSupervisor.UserStoreTest do
  use ExUnit.Case

  alias TapaSupervisor.User
  alias TapaSupervisor.UserStore

  setup do
    {:ok, user_store} = start_supervised({UserStore, [name: UserStore.Test]})

    [user_store: user_store]
  end

  test "returns users close to a location", ctx do
    %{user_store: user_store} = ctx

    location = {52.5760184, 13.3517038}

    user1 = %User{location: {52.5751940, 13.3520287}, name: "u1", email: "u1@example.org"}
    user2 = %User{location: {150.0, 150.0}, name: "u2", email: "u2@example.org"}

    :ok = GenServer.call(user_store, {:store, user1})
    :ok = GenServer.call(user_store, {:store, user2})

    users = GenServer.call(user_store, {:users_close_from, location})

    assert users == [user1]
  end
end

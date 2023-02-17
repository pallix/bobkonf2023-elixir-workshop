defmodule TapaGenserver.DrynessNotifierTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias TapaGenserver.DrynessNotifier
  alias TapaGenserver.EmailSender
  alias TapaGenserver.User
  alias TapaGenserver.UserStore
  alias TapaGenserver.Tree
  alias TapaGenserver.TreeStore
  alias Uniq.UUID

  setup do
    {:ok, user_store} = start_supervised({UserStore, [name: UserStore.Test]})
    {:ok, tree_store} = start_supervised({TreeStore, [name: TreeStore.Test]})
    {:ok, email_sender} = start_supervised({EmailSender, [observer: self()]})

    {:ok, dryness_notifier} =
      start_supervised(
        {DrynessNotifier,
         [
           name: DrynessNotifier.Test,
           tree_store: tree_store,
           user_store: user_store,
           email_sender: email_sender
         ]}
      )

    [user_store: user_store, tree_store: tree_store, dryness_notifier: dryness_notifier]
  end

  test "can notify users when trees are too dry", ctx do
    %{user_store: user_store, tree_store: tree_store, dryness_notifier: dryness_notifier} = ctx

    close_user = %User{
      name: "John Doe",
      location: {52.5760184, 13.3517038},
      email: "j.doe@example.org"
    }

    far_user = %User{name: "Mac Kraken", location: {90, 90}, email: "m.kraken@example.org"}

    wet_tree_uuid = UUID.uuid1()

    wet_tree_close = %Tree{
      uuid: wet_tree_uuid,
      latitude: 52.575177,
      longitude: 13.352029,
      moisture: 80,
      specie: :platanus
    }

    dry_tree_uuid = UUID.uuid1()

    dry_tree_close = %Tree{
      uuid: dry_tree_uuid,
      latitude: 52.5751940,
      longitude: 13.3520287,
      moisture: 11,
      specie: :platanus
    }

    dry_tree_far_uuid = UUID.uuid1()

    dry_tree_far = %Tree{
      uuid: dry_tree_far_uuid,
      latitude: 90.0,
      longitude: 90.0,
      moisture: 5,
      specie: :platanus
    }

    GenServer.call(user_store, {:store, close_user})
    GenServer.call(user_store, {:store, far_user})
    GenServer.call(tree_store, {:store, wet_tree_close})
    GenServer.call(tree_store, {:store, dry_tree_close})
    GenServer.call(tree_store, {:store, dry_tree_far})

    log =
      capture_log(fn ->
        # force a call the notification function
        send(dryness_notifier, :notify_users)
        wait_for_emails(2)
      end)

    assert log =~
             "email to m.kraken@example.org with content: Tree located at 90.0, 90.0 is too dry"

    assert log =~
             "email to j.doe@example.org with content: Tree located at 52.575194, 13.3520287 is too dry"
  end

  defp wait_for_emails(0) do
  end

  defp wait_for_emails(count) do
    receive do
      {:sent, _} ->
        wait_for_emails(count - 1)
    after
      500 ->
        flunk("Email not sent")
    end
  end
end

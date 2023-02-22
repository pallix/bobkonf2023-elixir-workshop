defmodule TapaGenserver.EmailSenderTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias TapaGenserver.EmailSender

  setup do
    {:ok, email_sender} = start_supervised({EmailSender, [name: EmailSenderTest, observer: self()]})

    [email_server: email_sender]
  end

  test "logs the sent message to the console", ctx do
    %{email_server: email_sender} = ctx

    email = "user@example.org"

    assert capture_log(fn ->
             GenServer.cast(email_sender, {:send_email, email, "Tree A is too dry"})

             receive do
               {:sent, ^email} ->
                 # we just wait for the sending to be finished otherwise
                 # nothing will be printed to the console and the test will fail
                 nil
             end
           end) =~ ~r/Sending email to user@example.org with content: Tree A is too dry/
  end
end

defmodule TapaGenserver.EmailSender do
  @moduledoc """
  Sends notifications via emails.

  For the workshop we just log a message on the console instead of sending an
  email.
  """

  require Logger

  use GenServer

  #
  # Public API
  #

  def start_link(options) do
    observer = Keyword.get(options, :observer)
    GenServer.start_link(__MODULE__, observer, name: __MODULE__)
  end

  #
  # GenServer callbacks
  #

  def init(observer) do
    {:ok, observer}
  end

  def handle_cast({:send_email, email, content}, state) do
    do_send_email(email, content, state)
    {:noreply, state}
  end

  #
  # Private functions
  #

  defp do_send_email(email, content, observer) do
    Logger.info("Sending email to #{email} with content: #{content}")

    if observer do
      send(observer, {:sent, email})
    end
  end
end

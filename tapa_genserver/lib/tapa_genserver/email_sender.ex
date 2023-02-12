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

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def send_email(email, content) do
    GenServer.cast(__MODULE__, {:send_email, email, content})
  end

  #
  # GenServer callbacks
  #

  def init([]) do
    {:ok, []}
  end

  def handle_cast({:send_email, email, content}, state) do
    do_send_email(email, content)
    {:noreply, state}
  end

  #
  # Private functions
  #

  defp do_send_email(email, content) do
    Logger.info("Sending email to #{email} with content: #{content}")
  end

end

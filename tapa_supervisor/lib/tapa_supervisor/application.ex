defmodule TapaSupervisor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias TapaSupervisor.TreeStore
  alias TapaSupervisor.UserStore
  alias TapaSupervisor.DrynessNotifier
  alias TapaSupervisor.Reporting
  alias TapaSupervisor.EmailSender

  @impl true
  def start(_type, _args) do
    children = [
      TreeStore,
      UserStore,
      %{
        id: TapaSupervisor.ReportingSupervisor,
        start:
        {Supervisor, :start_link,
         [
           [
             DrynessNotifier,
             Reporting
           ],
           [strategy: :rest_for_one]
         ]}
      },
      EmailSender
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TapaSupervisor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

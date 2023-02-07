defmodule TapaObserver.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias TapaObserver.AuditLog
  alias TapaObserver.Store
  alias TapaObserver.TreeRegistration

  @impl true
  def start(_type, _args) do
    children = [
      TreeRegistration,
      Store,
      AuditLog
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TapaObserver.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

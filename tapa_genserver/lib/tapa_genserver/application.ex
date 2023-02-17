defmodule TapaGenserver.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias TapaGenserver.TreeStore
  alias TapaGenserver.UserStore
  alias TapaGenserver.DrynessNotifier

  @impl true
  def start(_type, _args) do
    children = [
      TreeStore,
      UserStore,
      DrynessNotifier
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TapaGenserver.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

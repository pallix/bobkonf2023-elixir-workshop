defmodule TapaObserver.MixProject do
  use Mix.Project

  def project do
    [
      app: :tapa_observer,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TapaObserver.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:geocalc, "~> 0.8"},
      {:uniq, "~> 0.1"},
      {:recon, "~> 2.5"}
    ]
  end
end

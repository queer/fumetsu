defmodule Fumetsu.MixProject do
  use Mix.Project

  def project do
    [
      app: :fumetsu,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Fumetsu.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:horde, "~> 0.8.3"},
      {:libcluster, "~> 3.2"},
      {:tesla, "~> 1.4"},
      {:finch, "~> 0.6"},
    ]
  end
end

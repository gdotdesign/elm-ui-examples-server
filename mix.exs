defmodule ElmUI.Mixfile do
  use Mix.Project

  def project do
    [app: :elm_ui_api,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: (Mix.env == :dev && [:exsync] || []) ++ [:maru, :postgrex, :ecto],
     mod: {ElmUI.API, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  def deps do
    [ {:maru, "~> 0.8"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 1.1"},
      {:exsync,     "~> 0.1", only: :dev },
      {:corsica, "~> 0.4"}
    ]
  end
end

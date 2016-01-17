use Mix.Config

config :maru, ElmUI.API,
  http: [port: System.get_env("PORT") || 8002]

config :elm_ui_api, ElmUI.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL") || "ecto://postgres:postgres@localhost/elixir-api"

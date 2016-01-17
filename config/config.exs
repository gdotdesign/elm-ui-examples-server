use Mix.Config

config :maru, ElmUI.API,
  http: [port: 8002]

config :elm_ui_api, ElmUI.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "elixir-api",
  username: "postgres",
  password: "postgres"

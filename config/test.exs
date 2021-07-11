use Mix.Config

config :ridex, Ridex.Repo,
  username: "postgres",
  password: "postgres",
  database: "ridex_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :ridex, RidexWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn

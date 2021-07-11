use Mix.Config

config :ridex,
  ecto_repos: [Ridex.Repo]

config :ridex, RidexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8N1qjHOA7yONiuvSlU4b1r4LJm6dpi6xzkfFtq/rPwCxLoWpReEJjJdGm5BwDd0W",
  render_errors: [view: RidexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ridex.PubSub,
  live_view: [signing_salt: "rfldnQG7"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :ridex, Ridex.Guardian,
  issuer: "ridex",
  secret_key: "VnpsbhrTh21q6W1U9MJ2ND8V5P8NzAikwqOSUJaQWmQMz5XXFdeoasPOCdPdY+XY"

import_config "#{Mix.env()}.exs"

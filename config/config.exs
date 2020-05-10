# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :otp_csv_parser,
  ecto_repos: [OtpCsvParser.Repo]

# Configures the endpoint
config :otp_csv_parser, OtpCsvParserWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xSa+94DPZNSY0lGfbzgfcaiyTJU1Iy/vuEv95NvmK1F7JwetPG1hC6ubcu9RfREL",
  render_errors: [view: OtpCsvParserWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OtpCsvParser.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "rjdINf9T"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

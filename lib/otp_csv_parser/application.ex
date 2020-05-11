defmodule OtpCsvParser.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      OtpCsvParser.Repo,
      # Start the endpoint when the application starts
      OtpCsvParserWeb.Endpoint,
      {Absinthe.Subscription, [OtpCsvParserWeb.Endpoint]},
      {Cachex, :processes},
    ]

    opts = [strategy: :one_for_one, name: OtpCsvParser.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    OtpCsvParserWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule OtpCsvParserWeb.Router do
  use OtpCsvParserWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug Plug.Logger
    plug :accepts, ["json"]
  end

  scope "/", OtpCsvParserWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: OtpCsvParserWeb.Api.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: OtpCsvParserWeb.Api.Schema,
      socket: OtpCsvParserWeb.UserSocket,
      context: %{pubsub: OtpCsvParserWeb.Endpoint}
  end
end

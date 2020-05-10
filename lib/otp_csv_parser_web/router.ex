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
    plug :accepts, ["json"]
  end

  scope "/", OtpCsvParserWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", OtpCsvParserWeb do
  #   pipe_through :api
  # end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: OtpCsvParserWeb.Api.Schema,
      interface: :simple,
      context: %{pubsub: OtpCsvParserWeb.Endpoint}
  end
end

defmodule RidexWeb.Router do
  use RidexWeb, :router

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

  scope "/", RidexWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", RidexWeb do
    pipe_through :api

    post "/authenticate", AuthenticationController, :authenticate
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RidexWeb.Telemetry
    end
  end
end

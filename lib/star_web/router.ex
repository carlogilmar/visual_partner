defmodule StarWeb.Router do
  use StarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {StarWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_pipeline do
    plug Star.Guardian.BrowserPipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", StarWeb do

    get "/", PageController, :index
    live "/admin", HomeLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", StarWeb do
  #   pipe_through :api
  # end
end

defmodule HyperlogWeb.Router do
  use HyperlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HyperlogWeb.Plugs.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HyperlogWeb do
    pipe_through :browser

    get "/auth/:provider/", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback
    post "/logout", AuthController, :delete

    get "/home", UserController, :home

    get "/", PageController, :index

  resources "/tutorials", TutorialController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HyperlogWeb do
  #   pipe_through :api
  # end
end

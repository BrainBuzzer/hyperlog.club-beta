defmodule HyperlogWeb.Router do
  use HyperlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HyperlogWeb.Plugs.SetAuth
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
    get "/connect_discord", UserController, :connect_discord
    get "/onboard", UserController, :user_onboard

    post "/roles", UserController, :assign_role

    get "/", PageController, :index

    resources "/tutorials", TutorialController

    get "/courses", CourseController, :index
    get "/courses/javascript/:chapter_slug/:lesson_slug", CourseController, :javascript_course_start

    get "/profile", UserController, :profile_page
    post "/profile/delete", UserController, :delete_user_profile

    get "/u/:username", UserController, :user_overview_page
  end

  # Other scopes may use custom stacks.
  # scope "/api", HyperlogWeb do
  #   pipe_through :api
  # end
end

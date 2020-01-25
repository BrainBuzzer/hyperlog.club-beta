defmodule HyperlogWeb.Router do
  use HyperlogWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", HyperlogWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/courses", CourseController, :index
    get "/courses/javascript/:chapter_slug/:lesson_slug", CourseController, :javascript_course_start

    get "/u/:username", UserController, :user_overview_page
  end

  scope "/", HyperlogWeb do
    pipe_through [:browser, :protected]
    get "/auth/:provider/", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback

    get "/profile", UserController, :profile_page
    get "/home", UserController, :home

    get "/projects", ProjectController, :user_projects
    get "/projects/create", ProjectController, :user_project_new
    get "/projects/create/:repo_name", ProjectController, :user_create_project_new
    post "/projects/create", ProjectController, :user_create_new_project_post

    get "/project/:project_id", ProjectController, :user_project_show

    post "/roles", UserController, :assign_role
    post "/profile/delete", UserController, :delete_user_profile
  end

  # Other scopes may use custom stacks.
  # scope "/api", HyperlogWeb do
  #   pipe_through :api
  # end
end

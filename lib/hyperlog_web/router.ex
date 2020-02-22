defmodule HyperlogWeb.Router do
  use HyperlogWeb, :router
  use Sentry.Plug
  use Plug.ErrorHandler
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router, extensions: [PowInvitation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug HyperlogWeb.EnsureRolePlug, :admin
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: HyperlogWeb.AuthErrorHandler
  end

  pipeline :not_protected do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: HyperlogWeb.AuthErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HyperlogWeb do
    pipe_through :browser
    get "/tos", PageController, :terms_of_service
    get "/privacy", PageController, :privacy
  end

  scope "/admin", PowInvitation.Phoenix, as: "pow_invitation" do
    pipe_through [:browser, :protected, :admin]

    resources "/invitations", InvitationController, only: [:new, :create, :show]
  end

  scope "/", HyperlogWeb do
    pipe_through [:browser, :not_protected]

    get "/", PageController, :index
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login

    resources "/invitations", InvitationController, only: [:edit, :update]
  end

  scope "/" do
    pipe_through [:browser, :not_protected]

    pow_extension_routes()
  end

  scope "/", HyperlogWeb do
    pipe_through [:browser, :protected]

    delete "/logout", SessionController, :delete, as: :logout

    get "/auth/:provider/", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback

    # get "/u/:username", UserController, :user_overview_page
    get "/profile", UserController, :profile_page
    get "/profile/roles", UserController, :roles_page
    get "/home", UserController, :home

    get "/projects", ProjectController, :user_projects
    get "/projects/create", ProjectController, :user_project_new
    get "/projects/create/:username/:repo_name", ProjectController, :user_create_project_new
    post "/projects/create", ProjectController, :user_create_new_project_post

    get "/project/:project_id", ProjectController, :user_project_show

    post "/profile/roles", UserController, :assign_role
    post "/profile/delete", UserController, :delete_user_profile

    get "/courses/javascript/:chapter_slug/:lesson_slug", CourseController, :javascript_course_start
  end

  scope "/.well-known/acme-challenge", HyperlogWeb do
    get "/:challenge", AcmeChallengeController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", HyperlogWeb do
  #   pipe_through :api
  # end
end

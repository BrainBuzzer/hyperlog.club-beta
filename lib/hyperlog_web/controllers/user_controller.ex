defmodule HyperlogWeb.UserController do
  use HyperlogWeb, :controller

  def home(conn, _params) do
    render(conn, "home.html", current_user: get_session(conn, :current_user))
  end
end

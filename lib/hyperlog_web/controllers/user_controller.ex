defmodule HyperlogWeb.UserController do
  use HyperlogWeb, :controller

  def home(conn, _params) do
    if conn.assigns.current_user do
      render(conn, "home.html", current_user: conn.assigns.current_user)
    else
      conn
      |> redirect(to: "/")
    end
  end

end

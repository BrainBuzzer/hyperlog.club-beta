defmodule HyperlogWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You need to sign in or sign up before continuing.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end

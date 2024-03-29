defmodule HyperlogWeb.AuthErrorHandler do
  use HyperlogWeb, :controller
  alias Plug.Conn

  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, :not_authenticated) do
    conn
    |> put_flash(:error, "You've to be authenticated first")
    |> redirect(to: Routes.login_path(conn, :new))
  end

  def call(conn, :already_authenticated) do
    conn
    |> put_flash(:error, "You're already authenticated")
    |> redirect(to: Routes.user_path(conn, :home))
  end
end

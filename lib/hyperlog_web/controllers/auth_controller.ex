defmodule HyperlogWeb.AuthController do
  use HyperlogWeb, :controller

  plug Ueberauth

  alias Hyperlog.Accounts

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case auth.provider do
      :github ->
        with {:ok, user} <- Accounts.link_user_with_github(Pow.Plug.current_user(conn), auth.credentials.token) do
          sign_in_user(user, conn)
        end
      :discord ->
        with {:ok, user} <- Accounts.get_user_by_email(%{email: Pow.Plug.current_user(conn).email}) do
          if user.discord_connected do
            conn
            |> put_flash(:info, "Discord is already connected")
            |> redirect(to: "/home")
          else
            connect_discord(user, auth, conn)
          end
        end
    end
  end

  defp sign_in_user(user, conn) do
    conn
    |> sync_user(user)
    |> put_flash(:info, "Github Connected Successfully.")
    |> redirect(to: "/home")
  end

  defp connect_discord(user, auth, conn) do
    HyperlogWeb.MessagingQueue.send_discord_token(auth.credentials.token, auth.uid)
    {:ok, user} = Accounts.connect_discord(user, auth)
    conn
    |> sync_user(user)
    |> put_flash(:info, "Discord connected successfully")
    |> redirect(to: "/home")
  end

end

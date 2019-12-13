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
        with {:ok, user} <- UserFromAuth.find_or_create(auth),
            {:ok, user} <- Accounts.get_or_create_user(user) do
          sign_in_user(user, conn)
        end
      :discord ->
        with {:ok, user} <- Accounts.get_user_by_email(%{email: auth.info.email}) do
          if user.discord_connected do
            conn
            |> put_flash(:warn, "Discord is already connected")
            |> redirect(to: "/home")
          else
            connect_discord(user, auth, conn)
          end
        end
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> clear_session()
    |> redirect(to: "/")
  end

  defp sign_in_user(user, conn) do
    redirect_path = if user.discord_connected, do: "/home", else: "/connect_discord"
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> put_session(:current_user_id, user.id)
    |> configure_session(renew: true)
    |> redirect(to: redirect_path)
  end

  defp connect_discord(user, auth, conn) do
    HyperlogWeb.MessagingQueue.send_discord_token(auth.credentials.token, auth.uid)
    Accounts.connect_discord(user, auth)
    conn
    |> put_flash(:info, "Discord connected successfully")
    |> redirect(to: "/home")
  end

end

defmodule HyperlogWeb.UserController do
  use HyperlogWeb, :controller

  alias Hyperlog.Accounts

  def home(conn, _params) do
    if conn.assigns.current_user do
      if conn.assigns.current_user.onboard_complete do
        render(conn, "home.html", current_user: conn.assigns.current_user)
      else
        redirect(conn, to: "/onboard")
      end
    else
      conn
      |> redirect(to: "/")
    end
  end

  def connect_discord(conn, _params) do
    if conn.assigns.current_user.discord_connected do
      redirect(conn, to: "/home")
    else
      render(conn, "discord_conn.html")
    end
  end

  def user_onboard(conn, _params) do
    if conn.assigns.current_user.onboard_complete do
      redirect(conn, to: "/home")
    else
      render(conn, "onboard.html")
    end
  end

  def assign_role(conn, %{"roles" => %{"experience_role" => role1, "position_role" => role2}}) do
    received_roles = [role1, role2]
    with {:ok, _user} <- add_role(conn.assigns.current_user, received_roles) do
      conn
      |> put_flash(:info, "Roles Assigned!")
      |> render("home.html")
    end
  end

  defp add_role(user, roles_id) do
    {:ok, user} = Accounts.assign_role_to_user(user, roles_id)
    HyperlogWeb.MessagingQueue.send_role_data(user.discord.discord_uid, roles_id, "ADD_ROLE")
    {:ok, user}
  end

  def profile_page(conn, _params) do
    if conn.assigns.current_user do
      render(conn, "profile.html", user: conn.assigns.current_user)
    else
      redirect(conn, to: "/login")
    end
  end

  def delete_user_profile(conn, _params) do
    if conn.assigns.current_user do
      Accounts.delete_user(conn.assigns.current_user.id)
      conn
      |> put_flash(:info, "Account deleted successfully")
      |> redirect(to: "/")
    else
      redirect(conn, to: "/")
    end
  end

  # defp remove_role(user, roles_id) do
  #   {:ok, user} = Accounts.unassigns_roles_from_user(user, roles_id)
  #   HyperlogWeb.MessagingQueue.send_role_data(user.discord.discord_uid, roles_id, "REMOVE_ROLE")
  #   {:ok, user}
  # end
end

defmodule HyperlogWeb.UserController do
  use HyperlogWeb, :controller

  alias Hyperlog.Accounts

  def home(conn, _params) do
    if conn.assigns.current_user do
      render(conn, "home.html", current_user: conn.assigns.current_user)
    else
      conn
      |> redirect(to: "/")
    end
  end

  def roles(conn, _params) do
    roles = Accounts.list_roles()
    render(conn, "roles.html", roles: roles)
  end

  def assign_role(conn, %{"roles" => %{"roles" => received_roles}}) do
    roles = Accounts.list_roles()
    with {:ok, _user} <- add_role(conn.assigns.current_user, received_roles) do
      conn
      |> put_flash(:info, "Role Assigned!")
      |> render("roles.html", roles: roles)
    end
  end

  defp add_role(user, roles_id) do
    {:ok, user} = Accounts.assign_role_to_user(user, roles_id)
    HyperlogWeb.MessagingQueue.send_role_data(user.discord.discord_uid, roles_id, "ADD_ROLE")
    {:ok, user}
  end

  defp remove_role(user, roles_id) do
    {:ok, user} = Accounts.unassigns_roles_from_user(user, roles_id)
    HyperlogWeb.MessagingQueue.send_role_data(user.discord.discord_uid, roles_id, "REMOVE_ROLE")
    {:ok, user}
  end
end

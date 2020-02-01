defmodule HyperlogWeb.UserController do
  use HyperlogWeb, :controller

  alias Hyperlog.Accounts

  def home(conn, _params) do
    render(conn, "home.html")
  end

  def roles_page(conn, _params) do
    roles = Accounts.list_roles
    current_user = Pow.Plug.current_user(conn)
    user = Hyperlog.Accounts.get_user!(current_user.id)
    experience_current_role = Enum.at(Enum.flat_map(user.roles, fn role ->
      case String.equivalent?("experience", role.type) do
        true -> [role.discord_id]
        false -> []
      end
    end), 0)
    position_current_role = Enum.at(Enum.flat_map(user.roles, fn role ->
      case String.equivalent?("position", role.type) do
        true -> [role.discord_id]
        false -> []
      end
    end), 0)
    languages = Enum.flat_map(user.roles, fn role ->
      case String.equivalent?("language", role.type) do
        true -> [role.discord_id]
        false -> []
      end
    end)
    render(conn, "roles.html", [roles: roles, experience: experience_current_role, position: position_current_role, languages: languages])
  end

  def assign_role(conn, %{"roles" => %{"experience_role" => role1, "position_role" => role2, "language_role" => role_array}}) do
    received_roles = [role1, role2] ++ role_array
    with {:ok, user} <- add_role(Pow.Plug.current_user(conn), received_roles) do
      conn
      |> sync_user(user)
      |> put_flash(:info, "Roles Assigned!")
      |> render("home.html")
    end
  end

  def assign_role(conn, %{"roles" => %{"experience_role" => role1, "position_role" => role2}}) do
    received_roles = [role1, role2]
    with {:ok, user} <- add_role(Pow.Plug.current_user(conn), received_roles) do
      conn
      |> sync_user(user)
      |> put_flash(:info, "Roles Assigned!")
      |> render("home.html")
    end
  end

  defp add_role(user, roles_id) do
    {:ok, user} = Accounts.assign_role_to_user(user, roles_id)
    discord = Hyperlog.Repo.get_by(Hyperlog.Accounts.Discord, %{user_id: user.id})
    HyperlogWeb.MessagingQueue.send_role_data(discord.discord_uid, roles_id, "ADD_ROLE")
    {:ok, user}
  end

  def profile_page(conn, _params) do
    render(conn, "profile.html", current_user: Pow.Plug.current_user(conn))
  end

  def delete_user_profile(conn, _params) do
    Accounts.delete_user(conn.assigns.current_user.id)
    conn
    |> put_flash(:info, "Account deleted successfully")
    |> redirect(to: "/")
  end

  def user_overview_page(conn, %{"username" => username}) do
    user = Accounts.get_user_by_username(username)
    render(conn, "overview.html", user: user)
  end

  # defp remove_role(user, roles_id) do
  #   {:ok, user} = Accounts.unassigns_roles_from_user(user, roles_id)
  #   HyperlogWeb.MessagingQueue.send_role_data(user.discord.discord_uid, roles_id, "REMOVE_ROLE")
  #   {:ok, user}
  # end
end

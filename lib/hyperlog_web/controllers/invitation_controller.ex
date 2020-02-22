defmodule HyperlogWeb.InvitationController do
  use HyperlogWeb, :controller

  alias PowInvitation.Plug
  alias Hyperlog.Repo

  plug :require_not_authenticated
  plug :load_user_from_invitation_token

  def edit(conn, _params) do
    changeset = Plug.change_user(conn)

    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    case Plug.update_user(conn, user_params) do
      {:ok, user, conn} ->
        user_profile = Ecto.build_assoc(user, :profile, %Hyperlog.Profile.User{}) |> Repo.insert!
        Hyperlog.Profile.add_achievement_to_user(user_profile.id, "hello_world")
        conn
        |> put_flash(:info, "User created")
        |> redirect(to: Routes.user_path(conn, :home))

      {:error, changeset, conn} ->
        conn
        |> assign(:changeset, changeset)
        |> render("edit.html")
    end
  end

  defdelegate require_not_authenticated(conn, opts), to: Pow.Phoenix.Controller

  defp load_user_from_invitation_token(%{params: %{"id" => token}} = conn, _opts) do
    case Plug.invited_user_from_token(conn, token) do
      nil  ->
        conn
        |> put_flash(:error, "Invalid invitation")
        |> redirect(to: Routes.login_path(conn, :new))
        |> halt()

      user ->
        Plug.assign_invited_user(conn, user)
    end
  end
end

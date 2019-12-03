defmodule HyperlogWeb.TutorialController do
  use HyperlogWeb, :controller

  alias Hyperlog.Resources
  alias Hyperlog.Resources.Tutorial

  plug :load_technologies when action in [:new, :create, :edit, :update]
  plug :load_categories when action in [:new, :create, :edit, :update]

  plug HyperlogWeb.Plugs.AuthenticateUser when action not in []

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, user) do
    tutorials = Resources.get_user_tutorials(user)
    render(conn, "index.html", tutorials: tutorials)
  end

  def new(conn, _params, _user) do
    changeset = Resources.change_tutorial(%Tutorial{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tutorial" => tutorial_params}, current_user) do
    case Resources.create_tutorial(current_user, tutorial_params) do
      {:ok, tutorial} ->
        conn
        |> put_flash(:info, "Tutorial created successfully.")
        |> redirect(to: Routes.tutorial_path(conn, :show, tutorial))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    tutorial = Resources.get_user_tutorial!(user, id)
    render(conn, "show.html", tutorial: tutorial)
  end

  def edit(conn, %{"id" => id}, user) do
    tutorial = Resources.get_user_tutorial!(user, id)
    changeset = Resources.change_tutorial(tutorial)
    render(conn, "edit.html", tutorial: tutorial, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tutorial" => tutorial_params}, user) do
    tutorial = Resources.get_user_tutorial!(user, id)

    case Resources.update_tutorial(tutorial, tutorial_params) do
      {:ok, tutorial} ->
        conn
        |> put_flash(:info, "Tutorial updated successfully.")
        |> redirect(to: Routes.tutorial_path(conn, :show, tutorial))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tutorial: tutorial, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    tutorial = Resources.get_user_tutorial!(user, id)
    {:ok, _tutorial} = Resources.delete_tutorial(tutorial)

    conn
    |> put_flash(:info, "Tutorial deleted successfully.")
    |> redirect(to: Routes.tutorial_path(conn, :index))
  end

  defp load_technologies(conn, _) do
    assign(conn, :technologies, Resources.list_technology)
  end

  defp load_categories(conn, _) do
    assign(conn, :categories, Resources.list_category)
  end
end

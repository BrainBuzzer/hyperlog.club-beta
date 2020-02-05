defmodule HyperlogWeb.ProjectController do
  use HyperlogWeb, :controller
  alias Hyperlog.Project
  alias Hyperlog.Project.MetaData
  alias Hyperlog.Accounts

  def user_projects(conn, _params) do
    projects = Project.get_projects_by_user_id(conn.assigns.current_user.id)
    conn
    |> assign(:projects, projects)
    |> assign(:current_user, conn.assigns.current_user)
    |> render("projects.html")
  end

  def user_project_new(conn, _params) do
    {:ok, %HTTPoison.Response{body: repos}} = HTTPoison.get("https://api.github.com/users/#{conn.assigns.current_user.username}/repos?per_page=1000")
    repos = Poison.decode!(repos)
    render(conn, "new.html", repos: repos)
  end

  def user_create_project_new(conn, %{"repo_name" => repo_name}) do
    {:ok, %HTTPoison.Response{body: repo}} = HTTPoison.get("https://api.github.com/repos/#{conn.assigns.current_user.username}/#{repo_name}")
    repo = Poison.decode!(repo)
    changeset = MetaData.changeset(%MetaData{}, %{
      name: repo["name"],
      description: repo["description"],
      link: repo["html_url"]
    })
    render(conn, "create.html", changeset: changeset)
  end

  def user_create_new_project_post(conn, %{"meta_data" => project_params}) do
    user = Accounts.get_user!(conn.assigns.current_user.id)
    case Project.create_project(user, project_params) do
      {:ok, _project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "create.html", changeset: changeset)
    end
  end

  def user_project_show(conn, %{"project_id" => project_id}) do
    project = Project.get_meta_data!(project_id)
    render(conn, "show.html", project: project)
  end
end

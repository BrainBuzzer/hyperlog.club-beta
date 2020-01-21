defmodule HyperlogWeb.ProjectController do
  use HyperlogWeb, :controller
  alias Hyperlog.Project

  def user_projects(conn, _params) do
    if conn.assigns.current_user do
      projects = Project.get_projects_by_user_id(conn.assigns.current_user.id)
      conn
      |> assign(:projects, projects)
      |> assign(:current_user, conn.assigns.current_user)
      |> render("projects.html")
    else
      redirect(conn, to: "/")
    end
  end

  def user_project_new(conn, _params) do
    if conn.assigns.current_user do
      {:ok, %HTTPoison.Response{body: repos}} = HTTPoison.get("https://api.github.com/users/#{conn.assigns.current_user.username}/repos?per_page=1000")
      repos = Poison.decode!(repos)
      render(conn, "new.html", repos: repos)
    else
      redirect(conn, to: "/")
    end
  end
end

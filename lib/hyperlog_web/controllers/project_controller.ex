defmodule HyperlogWeb.ProjectController do
  use HyperlogWeb, :controller
  alias Hyperlog.Project
  alias Hyperlog.Project.MetaData
  alias Hyperlog.Accounts

  def user_projects(conn, _params) do
    user = Pow.Plug.current_user(conn)
    projects = Project.get_projects_by_user_id(user.id)
    conn
    |> assign(:projects, projects)
    |> render("projects.html")
  end

  def user_project_new(conn, _params) do
    user = Pow.Plug.current_user(conn)
    case user.github_connected do
      true ->
        github = Hyperlog.Accounts.get_github_by_user(user.id)
        {:ok, %Neuron.Response{body: body}} = HyperlogWeb.PullGithubData.pull_user_repo(github.access_token)
        render(conn, "new.html", repos: body["data"]["viewer"]["repositories"]["edges"])
      false ->
        conn
        |> put_flash(:error, "Please connect to GitHub to create new projects")
        |> redirect(to: "/home")
    end
  end

  def user_create_project_new(conn, %{"repo_name" => repo_name, "username" => username}) do
    {:ok, %HTTPoison.Response{body: repo}} = HTTPoison.get("https://api.github.com/repos/#{username}/#{repo_name}")
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
      {:ok, project} ->
        HyperlogWeb.MessagingQueue.send_github_project(project.link)
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: "/project/#{project.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "create.html", changeset: changeset)
    end
  end

  def user_project_show(conn, %{"project_id" => project_id}) do
    project = Project.get_meta_data!(project_id)
    render(conn, "show.html", project: project)
  end
end

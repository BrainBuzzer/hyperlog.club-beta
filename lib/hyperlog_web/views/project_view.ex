defmodule HyperlogWeb.ProjectView do
  use HyperlogWeb, :view

  def title("projects.html", _), do: "Projects | Hyperlog"
  def title("new.html", _), do: "New Project | Hyperlog"
  def title("create.html", _), do: "New Project | Hyperlog"
  def title("show.html", %{project: project}), do: "#{project.name} | Hyperlog"
end

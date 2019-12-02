defmodule HyperlogWeb.TutorialView do
  use HyperlogWeb, :view

  def create_select_options(resources) do
    for resource <- resources, do: {resource.name, resource.id}
  end

end

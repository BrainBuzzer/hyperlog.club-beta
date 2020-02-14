defmodule HyperlogWeb.UserView do
  use HyperlogWeb, :view

  def title("home.html", _), do: "Home | Hyperlog"
  def title("profile.html", _), do: "Profile | Hyperlog"
  def title("roles.html", _), do: "Roles | Hyperlog"
end

defmodule HyperlogWeb.PageView do
  use HyperlogWeb, :view

  def title("privacy.html", _), do: "Privacy | Hyperlog"
  def title("terms_of_service.html", _), do: "Terms of Service | Hyperlog"
end

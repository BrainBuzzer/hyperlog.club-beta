defmodule HyperlogWeb.PageController do
  use HyperlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def terms_of_service(conn, _params) do
    render(conn, "terms_of_service.html")
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html")
  end
end

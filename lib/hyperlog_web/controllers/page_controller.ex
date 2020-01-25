defmodule HyperlogWeb.PageController do
  use HyperlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

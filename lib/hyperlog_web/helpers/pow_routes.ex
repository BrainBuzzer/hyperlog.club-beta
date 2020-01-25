defmodule HyperlogWeb.Pow.Routes do
  use Pow.Phoenix.Routes
  alias HyperlogWeb.Router.Helpers, as: Routes

  @impl true
  def after_sign_out_path(conn), do: Routes.page_path(conn, :index)

  @impl true
  def after_sign_in_path(conn), do: Routes.user_path(conn, :home)

  @impl true
  def user_already_authenticated_path(conn), do: Routes.user_path(conn, :home)
end

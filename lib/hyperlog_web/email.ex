defmodule HyperlogWeb.Email do
  use Bamboo.Phoenix, view: HyperlogWeb.EmailView

  def welcome_email(user) do
    base_email()
    |> to(user)
    |> subject("Welcome to hyperlog.Club")
    |> render("welcome.html")
  end

  defp base_email do
    new_email()
    |> from("hyperlog.Club <noreply@hyperlog.club>")
    |> put_html_layout({HyperlogWeb.LayoutView, "email.html"})
  end
end

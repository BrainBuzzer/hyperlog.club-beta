defmodule HyperlogWeb.Email do
  use Bamboo.Phoenix, view: HyperlogWeb.EmailView

  def invitation_email(user) do
    base_email()
    |> to(user.to)
    |> subject(user.subject)
    |> html_body(user.html)
    |> text_body(user.text)
  end

  defp base_email do
    new_email()
    |> from("hyperlog.Club <noreply@hyperlog.club>")
    |> put_html_layout({HyperlogWeb.LayoutView, "email.html"})
  end
end

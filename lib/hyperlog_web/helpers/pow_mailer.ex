defmodule HyperlogWeb.PowMailer do
  use Pow.Phoenix.Mailer
  require Logger

  def cast(%{user: user, subject: subject, text: text, html: html, assigns: _assigns}) do
    # Build email struct to be used in `process/1`

    %{to: user.email, subject: subject, text: text, html: html}
  end

  def process(email) do
    # Send email

    HyperlogWeb.Email.invitation_email(email)
    |> HyperlogWeb.Mailer.deliver_now
  end
end

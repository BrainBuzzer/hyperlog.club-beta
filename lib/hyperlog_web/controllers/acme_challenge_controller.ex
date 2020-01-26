defmodule HyperlogWeb.AcmeChallengeController do
  use HyperlogWeb, :controller

  def show(conn, %{"challenge" => file_name}) do
    base_path = System.get_env("ACME_CHALLENGE_DIR")
    # Sanitize filename to prevent a directory-traversal attack
    safe_file_name = Path.basename(file_name)

    case File.read(Path.join([base_path, "/.well-known/acme-challenge", safe_file_name])) do
      {:ok, content} ->

        send_resp(conn, 200, content)
      _ ->
        send_resp(conn, 200, "Not Valid")
    end
  end

  def show(conn, _) do
    send_resp(conn, 200, "Not Valid")
  end
end

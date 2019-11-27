defmodule UserFromAuth do
  require Logger
  require Poison

  alias Ueberauth.Auth

  def find_or_create(%Auth{} = auth) do
    {:ok, basic_info(auth)}
  end

  defp avatar_from_auth(%{info: %{urls: %{avatar_url: image}}}), do: image

  defp basic_info(auth) do
    IO.inspect auth
    %{
      id: auth.uid,
      avatar: avatar_from_auth(auth),
      name: name_from_auth(auth),
      email: email_from_auth(auth),
      username: username_from_auth(auth)
    }
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name =
        [auth.info.first_name, auth.info.last_name]
        |> Enum.filter(&(&1 != nil and &1 != ""))

      if Enum.empty?(name) do
        auth.info.nickname
      else
        Enum.join(name, " ")
      end
    end
  end

  defp email_from_auth(auth), do: auth.info.email

  defp username_from_auth(auth), do: auth.info.nickname

end

defmodule HyperlogWeb.RegistrationController do
  use HyperlogWeb, :controller

  def new(conn, _params) do
    # We'll leverage [`Pow.Plug`](Pow.Plug.html), but you can also follow the classic Phoenix way:
    # changeset = MyApp.Users.User.changeset(%MyApp.Users.User{}, %{})

    changeset = Pow.Plug.change_user(conn)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    # We'll leverage [`Pow.Plug`](Pow.Plug.html), but you can also follow the classic Phoenix way:
    # user =
    #   %MyApp.Users.User{}
    #   |> MyApp.Users.User.changeset(user_params)
    #   |> MyApp.Repo.insert()

    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
      {:ok, user, conn} ->
        conn
        |> put_flash(:info, "Welcome!")
        |> redirect(to: Routes.user_path(conn, :home))

      {:error, changeset, conn} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
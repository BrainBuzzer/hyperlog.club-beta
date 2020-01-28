defmodule Hyperlog.Profile do
  @moduledoc """
  The Profile context.
  """

  import Ecto.Query, warn: false
  alias Hyperlog.Repo

  alias Hyperlog.Profile.User

  @doc """
  Returns the list of user_profile.

  ## Examples

      iex> list_user_profile()
      [%User{}, ...]

  """
  def list_user_profile do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id) |> Repo.preload(:achievements)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Hyperlog.Profile.Achievements

  @doc """
  Returns the list of achievements.

  ## Examples

      iex> list_achievements()
      [%Achievements{}, ...]

  """
  def list_achievements do
    Repo.all(Achievements)
  end

  @doc """
  Gets a single achievements.

  Raises `Ecto.NoResultsError` if the Achievements does not exist.

  ## Examples

      iex> get_achievements!(123)
      %Achievements{}

      iex> get_achievements!(456)
      ** (Ecto.NoResultsError)

  """
  def get_achievements!(id), do: Repo.get!(Achievements, id)

  @doc """
  Creates a achievements.

  ## Examples

      iex> create_achievements(%{field: value})
      {:ok, %Achievements{}}

      iex> create_achievements(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_achievements(attrs \\ %{}) do
    %Achievements{}
    |> Achievements.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a achievements.

  ## Examples

      iex> update_achievements(achievements, %{field: new_value})
      {:ok, %Achievements{}}

      iex> update_achievements(achievements, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_achievements(%Achievements{} = achievements, attrs) do
    achievements
    |> Achievements.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Achievements.

  ## Examples

      iex> delete_achievements(achievements)
      {:ok, %Achievements{}}

      iex> delete_achievements(achievements)
      {:error, %Ecto.Changeset{}}

  """
  def delete_achievements(%Achievements{} = achievements) do
    Repo.delete(achievements)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking achievements changes.

  ## Examples

      iex> change_achievements(achievements)
      %Ecto.Changeset{source: %Achievements{}}

  """
  def change_achievements(%Achievements{} = achievements) do
    Achievements.changeset(achievements, %{})
  end

  def add_achievement_to_user(%User{} = user, achievements) do
    achievements = Enum.map(achievements, fn id -> get_achievements!(id) end)
    user
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:achievements, achievements)
    |> Repo.update()
  end
end

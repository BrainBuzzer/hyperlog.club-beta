defmodule Hyperlog.Resources do
  @moduledoc """
  The Resources context.
  """

  import Ecto.Query, warn: false
  alias Hyperlog.Repo

  alias Hyperlog.Resources.Category

  @doc """
  Returns the list of category.

  ## Examples

      iex> list_category()
      [%Category{}, ...]

  """
  def list_category do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(name) do
    Repo.insert!(%Category{name: name}, on_conflict: :nothing)
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  alias Hyperlog.Resources.Technology

  @doc """
  Returns the list of technology.

  ## Examples

      iex> list_technology()
      [%Technology{}, ...]

  """
  def list_technology do
    Repo.all(Technology)
  end

  @doc """
  Gets a single technology.

  Raises `Ecto.NoResultsError` if the Technology does not exist.

  ## Examples

      iex> get_technology!(123)
      %Technology{}

      iex> get_technology!(456)
      ** (Ecto.NoResultsError)

  """
  def get_technology!(id), do: Repo.get!(Technology, id)

  @doc """
  Creates a technology.

  ## Examples

      iex> create_technology(name)
      {:ok, %Technology{}}

      iex> create_technology(name)
      {:error, %Ecto.Changeset{}}

  """
  def create_technology(name) do
    Repo.insert!(%Technology{name: name}, on_conflict: :nothing)
  end

  @doc """
  Updates a technology.

  ## Examples

      iex> update_technology(technology, %{field: new_value})
      {:ok, %Technology{}}

      iex> update_technology(technology, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_technology(%Technology{} = technology, attrs) do
    technology
    |> Technology.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Technology.

  ## Examples

      iex> delete_technology(technology)
      {:ok, %Technology{}}

      iex> delete_technology(technology)
      {:error, %Ecto.Changeset{}}

  """
  def delete_technology(%Technology{} = technology) do
    Repo.delete(technology)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking technology changes.

  ## Examples

      iex> change_technology(technology)
      %Ecto.Changeset{source: %Technology{}}

  """
  def change_technology(%Technology{} = technology) do
    Technology.changeset(technology, %{})
  end

  alias Hyperlog.Resources.Tutorial

  @doc """
  Returns the list of tutorials.

  ## Examples

      iex> list_tutorials()
      [%Tutorial{}, ...]

  """
  def list_tutorials do
    Repo.all(Tutorial)
  end

  @doc """
  Gets a single tutorial.

  Raises `Ecto.NoResultsError` if the Tutorial does not exist.

  ## Examples

      iex> get_tutorial!(123)
      %Tutorial{}

      iex> get_tutorial!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tutorial!(id), do: Repo.get!(Tutorial, id)

  @doc """
  Creates a tutorial.

  ## Examples

      iex> create_tutorial(%{field: value})
      {:ok, %Tutorial{}}

      iex> create_tutorial(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tutorial(%Hyperlog.Accounts.User{} = user, attrs \\ %{}) do
    %Tutorial{}
    |> Tutorial.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a tutorial.

  ## Examples

      iex> update_tutorial(tutorial, %{field: new_value})
      {:ok, %Tutorial{}}

      iex> update_tutorial(tutorial, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tutorial(%Tutorial{} = tutorial, attrs) do
    tutorial
    |> Tutorial.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tutorial.

  ## Examples

      iex> delete_tutorial(tutorial)
      {:ok, %Tutorial{}}

      iex> delete_tutorial(tutorial)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tutorial(%Tutorial{} = tutorial) do
    Repo.delete(tutorial)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tutorial changes.

  ## Examples

      iex> change_tutorial(tutorial)
      %Ecto.Changeset{source: %Tutorial{}}

  """
  def change_tutorial(%Tutorial{} = tutorial) do
    Tutorial.changeset(tutorial, %{})
  end

end

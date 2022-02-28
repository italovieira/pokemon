defmodule Pokepet.Team do
  @moduledoc """
  The Team context.
  """

  import Ecto.Query, warn: false
  alias Pokepet.Repo

  alias Pokepet.Team.Pokemon

  @doc """
  Returns the list of pokemons.

  ## Examples

      iex> list_pokemons()
      [%Pokemon{}, ...]

  """
  def list_pokemons do
    Repo.all(Pokemon)
  end

  @doc """
  Gets a single pokemon.

  Raises `Ecto.NoResultsError` if the Pokemon does not exist.

  ## Examples

      iex> get_pokemon!(123)
      %Pokemon{}

      iex> get_pokemon!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pokemon!(id), do: Repo.get!(Pokemon, id)

  @doc """
  Creates a pokemon.

  ## Examples

      iex> create_pokemon(%{field: value})
      {:ok, %Pokemon{}}

      iex> create_pokemon(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_pokemon(attrs \\ %{})

  def create_pokemon(%{"poke_id" => poke_id}) when is_integer(poke_id) do
    alias Pokepet.PokeAPI
    pokemon_name = PokeAPI.get_name_by_id(poke_id)
    create_pokemon(%{"name" => pokemon_name, "hunger" => 0})
  end

  def create_pokemon(attrs) do
    %Pokemon{}
    |> Pokemon.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pokemon.

  ## Examples

      iex> update_pokemon(pokemon, %{field: new_value})
      {:ok, %Pokemon{}}

      iex> update_pokemon(pokemon, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pokemon(%Pokemon{} = pokemon, attrs) do
    pokemon
    |> Pokemon.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pokemon.

  ## Examples

      iex> delete_pokemon(pokemon)
      {:ok, %Pokemon{}}

      iex> delete_pokemon(pokemon)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pokemon(%Pokemon{} = pokemon) do
    Repo.delete(pokemon)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pokemon changes.

  ## Examples

      iex> change_pokemon(pokemon)
      %Ecto.Changeset{data: %Pokemon{}}

  """
  def change_pokemon(%Pokemon{} = pokemon, attrs \\ %{}) do
    Pokemon.changeset(pokemon, attrs)
  end

  @doc """
  Feeds pokemon decreasing its hunger by 20

  ## Examples

      iex> feed_pokemon(pokemon)
      {:ok, %Pokemon{}}

      iex> feed_pokemon(pokemon)
      {:error, %Ecto.Changeset{}}

  """

  def feed_pokemon(%Pokemon{} = pokemon) do
    case pokemon do
      %{hunger: 150} ->
        {:error, "pokemon is passed out"}
      %{hunger: hunger} ->
        pokemon
        |> Pokemon.changeset(%{"hunger" => max(0, hunger - 20)})
        |> Repo.update()
    end
  end
end

defmodule PokepetWeb.PokemonController do
  use PokepetWeb, :controller

  alias Pokepet.Team
  alias Pokepet.Team.Pokemon

  action_fallback PokepetWeb.FallbackController

  def index(conn, _params) do
    pokemons = Team.list_pokemons()
    render(conn, "index.json", pokemons: pokemons)
  end

  def create(conn, %{"pokemon" => pokemon_params}) do
    with {:ok, %Pokemon{} = pokemon} <- Team.create_pokemon(pokemon_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.pokemon_path(conn, :show, pokemon))
      |> render("show.json", pokemon: pokemon)
    end
  end

  def show(conn, %{"id" => id}) do
    pokemon = Team.get_pokemon!(id)
    render(conn, "show.json", pokemon: pokemon)
  end

  def update(conn, %{"id" => id, "pokemon" => pokemon_params}) do
    pokemon = Team.get_pokemon!(id)

    with {:ok, %Pokemon{} = pokemon} <- Team.update_pokemon(pokemon, pokemon_params) do
      render(conn, "show.json", pokemon: pokemon)
    end
  end

  def delete(conn, %{"id" => id}) do
    pokemon = Team.get_pokemon!(id)

    with {:ok, %Pokemon{}} <- Team.delete_pokemon(pokemon) do
      send_resp(conn, :no_content, "")
    end
  end
end

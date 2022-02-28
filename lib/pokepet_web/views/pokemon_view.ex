defmodule PokepetWeb.PokemonView do
  use PokepetWeb, :view
  alias PokepetWeb.PokemonView

  def render("index.json", %{pokemons: pokemons}) do
    %{data: render_many(pokemons, PokemonView, "pokemon.json")}
  end

  def render("show.json", %{pokemon: pokemon}) do
    %{data: render_one(pokemon, PokemonView, "pokemon.json")}
  end

  def render("pokemon.json", %{pokemon: pokemon}) do
    %{
      id: pokemon.id,
      name: pokemon.name,
      hunger: pokemon.hunger,
    }
  end
end

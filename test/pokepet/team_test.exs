defmodule Pokepet.TeamTest do
  use Pokepet.DataCase

  alias Pokepet.Team

  describe "pokemons" do
    alias Pokepet.Team.Pokemon

    import Pokepet.TeamFixtures

    @invalid_attrs %{hunger: nil, name: nil}

    test "list_pokemons/0 returns all pokemons" do
      pokemon = pokemon_fixture()
      assert Team.list_pokemons() == [pokemon]
    end

    test "get_pokemon!/1 returns the pokemon with given id" do
      pokemon = pokemon_fixture()
      assert Team.get_pokemon!(pokemon.id) == pokemon
    end

    test "create_pokemon/1 with valid data creates a pokemon" do
      valid_attrs = %{hunger: 42, name: "some name"}

      assert {:ok, %Pokemon{} = pokemon} = Team.create_pokemon(valid_attrs)
      assert pokemon.hunger == 42
      assert pokemon.name == "some name"
    end

    test "create_pokemon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_pokemon(@invalid_attrs)
    end

    test "update_pokemon/2 with valid data updates the pokemon" do
      pokemon = pokemon_fixture()
      update_attrs = %{hunger: 43, name: "some updated name"}

      assert {:ok, %Pokemon{} = pokemon} = Team.update_pokemon(pokemon, update_attrs)
      assert pokemon.hunger == 43
      assert pokemon.name == "some updated name"
    end

    test "update_pokemon/2 with invalid data returns error changeset" do
      pokemon = pokemon_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_pokemon(pokemon, @invalid_attrs)
      assert pokemon == Team.get_pokemon!(pokemon.id)
    end

    test "delete_pokemon/1 deletes the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{}} = Team.delete_pokemon(pokemon)
      assert_raise Ecto.NoResultsError, fn -> Team.get_pokemon!(pokemon.id) end
    end

    test "change_pokemon/1 returns a pokemon changeset" do
      pokemon = pokemon_fixture()
      assert %Ecto.Changeset{} = Team.change_pokemon(pokemon)
    end

    test "feed_pokemon/1 returns a pokemon changeset" do
      pokemon = pokemon_fixture(%{hunger: 42})
      assert {:ok, %Pokemon{hunger: 22}} = Team.feed_pokemon(pokemon)
    end

    test "feed_pokemon/1 returns a pokemon with non negative hunger" do
      pokemon = pokemon_fixture(%{hunger: 19})
      assert {:ok, %Pokemon{hunger: 0}} = Team.feed_pokemon(pokemon)
    end

    test "feed_pokemon/1 do nothing for fainted pokemon" do
      pokemon = pokemon_fixture(%{hunger: 150})
      assert {:error, _message} = Team.feed_pokemon(pokemon)
    end
  end
end

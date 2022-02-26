defmodule Pokepet.PokeAPITest do
  use Pokepet.DataCase

  @valid_arg 1
  @invalid_arg "naointeiro"

  describe "pokeapi" do
    alias Pokepet.PokeAPI

    test "given valid poke id returns pokemon name" do
      pokemon_name = PokeAPI.get_name_by_id(@valid_arg)
      assert pokemon_name == "bulbasaur"
    end

    test "given invalid poke id returns error" do
      assert_raise FunctionClauseError, fn ->
        PokeAPI.get_name_by_id(@invalid_arg)
      end
    end
  end
end

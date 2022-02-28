defmodule PokepetWeb.PokemonControllerTest do
  use PokepetWeb.ConnCase

  import Pokepet.TeamFixtures

  @create_attrs %{
    poke_id: 6
  }
  @invalid_attrs %{poke_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pokemons", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pokemon" do
    test "renders pokemon when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pokemon_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "charizard",
               "hunger" => 0,
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pokemon" do
    setup [:create_pokemon]

    test "deletes chosen pokemon", %{conn: conn, pokemon: pokemon} do
      conn = delete(conn, Routes.pokemon_path(conn, :delete, pokemon))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pokemon_path(conn, :show, pokemon))
      end
    end
  end

  describe "feed pokemon" do
    test "feeds chosen pokemon", %{conn: conn} do
      pokemon = pokemon_fixture(%{hunger: 42})
      conn = patch(conn, Routes.pokemon_feed_path(conn, :feed, pokemon))
      assert %{"id" => id} = json_response(conn, 200)["data"]

      assert %{
               "id" => ^id,
               "hunger" => 22,
             } = json_response(conn, 200)["data"]
    end

    test "try to feed fainted pokemon", %{conn: conn} do
      pokemon = pokemon_fixture(%{hunger: 150})
      conn = patch(conn, Routes.pokemon_feed_path(conn, :feed, pokemon))
      assert %{"message" => _message} = json_response(conn, 405)

      conn = get(conn, Routes.pokemon_path(conn, :show, pokemon.id))
      assert %{
               "hunger" => 150,
             } = json_response(conn, 200)["data"]
    end
  end

  defp create_pokemon(_) do
    pokemon = pokemon_fixture()
    %{pokemon: pokemon}
  end
end

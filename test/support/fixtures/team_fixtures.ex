defmodule Pokepet.TeamFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pokepet.Team` context.
  """

  @doc """
  Generate a pokemon.
  """
  def pokemon_fixture(attrs \\ %{}) do
    {:ok, pokemon} =
      attrs
      |> Enum.into(%{
        hunger: 42,
        name: "some name"
      })
      |> Pokepet.Team.create_pokemon()

    pokemon
  end
end

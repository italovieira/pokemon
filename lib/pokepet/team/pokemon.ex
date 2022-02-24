defmodule Pokepet.Team.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pokemons" do
    field :hunger, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :hunger])
    |> validate_required([:name, :hunger])
  end
end

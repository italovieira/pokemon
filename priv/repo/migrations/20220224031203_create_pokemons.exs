defmodule Pokepet.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string
      add :hunger, :integer

      timestamps()
    end
  end
end

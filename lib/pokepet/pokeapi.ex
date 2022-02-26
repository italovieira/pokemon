defmodule Pokepet.PokeAPI do
  @base_url "https://pokeapi.co/api/v2"

  def get_name_by_id(poke_id) when is_integer(poke_id) do
    case HTTPoison.get("#{@base_url}/pokemon/#{poke_id}") do
      {:ok, %{status_code: 200, body: body}} -> Poison.decode!(body)["name"]
      {:ok, %{status_code: _, body: _}} -> raise "error while trying to get pokemon name"
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect reason
    end
  end
end

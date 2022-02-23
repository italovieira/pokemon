defmodule Pokepet.Repo do
  use Ecto.Repo,
    otp_app: :pokepet,
    adapter: Ecto.Adapters.Postgres
end

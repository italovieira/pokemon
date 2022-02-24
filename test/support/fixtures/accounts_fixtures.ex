defmodule Pokepet.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pokepet.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        password: "some password"
      })
      |> Pokepet.Accounts.create_user()

    user
  end
end

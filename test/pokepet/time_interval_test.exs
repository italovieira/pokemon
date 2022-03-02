defmodule Pokepet.TimeIntervalTest do
  use ExUnit.Case, async: true

  alias Pokepet.TimeInterval

  test "test new shot" do
    # setup
    {:ok, server} = GenServer.start_link(TimeInterval, %{42 => ~N[2022-02-02 00:00:00]})

    TimeInterval.shot(server, 42)
    assert TimeInterval.lookup(server, 42) == 0
  end

  test "test get minutes passed" do
    # setup
    {:ok, server} = GenServer.start_link(TimeInterval, %{42 => NaiveDateTime.utc_now() |> NaiveDateTime.add(-300, :second)})

    assert TimeInterval.lookup(server, 42) == 5
  end
end

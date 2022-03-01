defmodule PokepetWeb.HungerHandlerTest do
  use ExUnit.Case, async: true

  alias PokepetWeb.HungerHandler

  setup do
    server = start_supervised!(HungerHandler)
    %{server: server}
  end

  test "test adding new pokemon state for handle its hunger", %{server: server} do
    assert HungerHandler.put(server, 42) == :ok
    assert HungerHandler.lookup(server, 42) == {:ok, 0}
  end

  test "test increase pokemon hunger", %{server: server} do
    HungerHandler.put(server, 42)
    assert HungerHandler.increase(server, 42) == :ok
    assert HungerHandler.increase(server, 42) == :ok
    assert HungerHandler.increase(server, 42) == :ok
    assert HungerHandler.lookup(server, 42) == {:ok, 3}
  end

  test "test feed pokemon", %{server: server} do
    assert HungerHandler.put(server, 42, 19) == :ok
    assert HungerHandler.lookup(server, 42) == {:ok, 19}
    IO.inspect HungerHandler.feed(server, 42)
    assert HungerHandler.lookup(server, 42) == {:ok, 0}
  end
end


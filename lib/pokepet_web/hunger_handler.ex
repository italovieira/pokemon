defmodule PokepetWeb.HungerHandler do
  use GenServer

def start_link(_) do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def put(server, pokemon_id, hunger \\ 0) do
    GenServer.call(server, {:put, pokemon_id, hunger})
  end

  def lookup(server, pokemon_id) do
    GenServer.call(server, {:lookup, pokemon_id})
  end

  def increase(server, pokemon_id, value \\ 1) do
    GenServer.cast(server, {:increase, pokemon_id, value})
  end

  def feed(server, pokemon_id, value \\ 20) do
    GenServer.call(server, {:feed, pokemon_id, value})
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:put, pokemon_id, hunger}, _from, state) do
    {:reply, :ok, Map.put(state, pokemon_id, hunger)}
  end

  @impl true
  def handle_call({:lookup, pokemon_id}, _from, state) do
    {:reply, Map.fetch(state, pokemon_id), state}
  end

  @impl true
  def handle_call({:feed, pokemon_id, value}, _from, state) do
    {:reply, :ok, Map.update(state, pokemon_id, 0, &(max(0, &1 - value)))}

  end
  @impl true
  def handle_cast({:increase, pokemon_id, value}, state) do
    {:noreply, Map.update(state, pokemon_id, 0, &(&1 + value))}
  end
end

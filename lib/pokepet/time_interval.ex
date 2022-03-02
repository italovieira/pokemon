defmodule Pokepet.TimeInterval do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Given a key saves current time
  """
  def shot(server, key) do
    GenServer.cast(server, {:shot, key, NaiveDateTime.utc_now()})
  end

  @doc """
  Given a key returns the minutes passed from old time to now
  """
  def lookup(server, key) do
    GenServer.call(server, {:lookup, key, NaiveDateTime.utc_now()})
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:shot, key, time}, state) do
    {:noreply, Map.put(state, key, time)}
  end

  @impl true
  def handle_call({:lookup, key, time}, _from, state) do
    minutes_passed = calculate_minutes_passed(time, state[key])
    {:reply, minutes_passed, state}
  end

  defp calculate_minutes_passed(new_time, old_time) do
    NaiveDateTime.diff(new_time, old_time) |> div(60)
  end
end

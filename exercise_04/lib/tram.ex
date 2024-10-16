defmodule Tram do
  @moduledoc """
  `Tram` implements a simple tram state machine.
  """

  use GenServer

  # Client

  @doc """
  Start Tram server process.

  ## Examples
      iex> {:ok, _pid} = Tram.start_link()
  """

  def start_link, do: GenServer.start_link(__MODULE__, nil)

  def move!(pid), do: GenServer.call(pid, :move)
  def stop!(pid), do: GenServer.call(pid, :stop)
  def open_doors!(pid), do: GenServer.call(pid, :open_doors)
  def close_doors!(pid), do: GenServer.call(pid, :close_doors)

  def stopped?(pid), do: GenServer.call(pid, :stopped?)
  def movement?(pid), do: GenServer.call(pid, :movement?)
  def doors_opened?(pid), do: GenServer.call(pid, :doors_opened?)
  defdelegate move?(pid), to: __MODULE__, as: :movement?

  # Server (callbacks)

  @impl true
  def init(_), do: {:ok, :stopped}

  @impl true
  def handle_call(:stop, _from, :stopped), do: {:reply, :ok, :stopped}
  def handle_call(:stop, _from, :movement), do: {:reply, :ok, :stopped}
  def handle_call(:stop, _from, :doors_opened), do: {:reply, :ok, :stopped}

  def handle_call(:move, _from, :movement), do: {:reply, :ok, :movement}
  def handle_call(:move, _from, :stopped), do: {:reply, :ok, :movement}
  def handle_call(:move, _from, :doors_opened), do: {:reply, :error, :doors_opened}

  def handle_call(:open_doors, _from, :doors_opened), do: {:reply, :ok, :doors_opened}
  def handle_call(:open_doors, _from, :stopped), do: {:reply, :ok, :doors_opened}
  def handle_call(:open_doors, _from, :movement), do: {:reply, :error, :movement}

  def handle_call(:close_doors, _from, :doors_opened), do: {:reply, :ok, :stopped}
  def handle_call(:close_doors, _from, :stopped), do: {:reply, :ok, :stopped}
  def handle_call(:close_doors, _from, :movement), do: {:reply, :ok, :movement}

  def handle_call(:stopped?, _from, :stopped), do: {:reply, true, :stopped}
  def handle_call(:stopped?, _from, state), do: {:reply, false, state}

  def handle_call(:movement?, _from, :movement), do: {:reply, true, :movement}
  def handle_call(:movement?, _from, state), do: {:reply, false, state}

  def handle_call(:doors_opened?, _from, :doors_opened), do: {:reply, true, :doors_opened}
  def handle_call(:doors_opened?, _from, state), do: {:reply, false, state}
end

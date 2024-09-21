defmodule EchoServer do
  @moduledoc """
  `EchoServer` implements a simple ping-pong server.
  Keeps track of the number of ping calls.
  Allows you to pass the initial state of the counter during initialization.
  """

  use GenServer

  # Client

  @doc """
  Start echo server process.

  ## Examples
      iex> {:ok, _pid} = EchoServer.start_link()
      iex> {:ok, _pid} = EchoServer.start_link(22)
  """

  def start_link(initial_number \\ 0) do
    GenServer.start_link(__MODULE__, initial_number)
  end

  @doc """
  Call ping.

  ## Examples
      iex> {:ok, pid} = EchoServer.start_link()
      iex> _current_node = node()
      iex> {:pong,  _current_node, 1} = EchoServer.ping(pid)
      iex> {:pong,  _current_node, 2} = EchoServer.ping(pid, :sync)

      iex> {:ok, pid} = EchoServer.start_link(33)
      iex> _current_node = node()
      iex> :ok = EchoServer.ping(pid, :async)
      iex> {:ok,  _current_node, 34} = EchoServer.number(pid)
  """

  def ping(pid, mode \\ :sync)
  def ping(pid, :sync) do
    GenServer.call(pid, :ping)
  end

  def ping(pid, :async) do
    GenServer.cast(pid, :ping)
  end

  @doc """
  Get current counter value.

  ## Examples
    iex> {:ok, pid} = EchoServer.start_link(2)
    iex> _current_node = node()
    iex> {:ok,  _current_node, 2} = EchoServer.number(pid)
  """

  def number(pid) do
    GenServer.call(pid, :get_number)
  end

  @doc """
  Knocks down the server process by raising an exception.
  """

  def bang!(pid) do
    GenServer.call(pid, :bang)
  end

  # Server (callbacks)

  @impl true
  def init(initial_number) do
    state = initial_number
    {:ok, state}
  end

  @impl true
  def handle_call(:ping, _from, state) do
    new_state = state + 1
    {:reply, {:pong, node(), new_state}, new_state}
  end

  def handle_call(:get_number, _from, state) do
    {:reply, {:ok, node(), state}, state}
  end

  def handle_call(:bang, _from, _state) do
    raise "The server has exploded!"
  end

  @impl true
  def handle_cast(:ping, state) do
    new_state = state + 1
    {:noreply, new_state}
  end
end

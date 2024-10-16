defmodule TramTest do
  use ExUnit.Case
  #doctest Tram

  setup do
    {:ok, pid} = Tram.start_link()
    {:ok, pid: pid}
  end

  test "default state", %{pid: pid} do
    assert Tram.stopped?(pid)
    refute Tram.movement?(pid)
    refute Tram.move?(pid)
    refute Tram.doors_opened?(pid)
  end

  test "move!", %{pid: pid} do
    assert Tram.stopped?(pid)
    assert Tram.move!(pid) == :ok
    assert Tram.movement?(pid)
    assert Tram.move!(pid) == :ok

    assert Tram.open_doors!(pid) == :error
    refute Tram.doors_opened?(pid)
    assert Tram.movement?(pid)
  end

  test "stop!", %{pid: pid} do
    assert Tram.move!(pid) == :ok
    assert Tram.movement?(pid)
    assert Tram.stop!(pid) == :ok
    assert Tram.stopped?(pid)
    assert Tram.stop!(pid) == :ok

    assert Tram.open_doors!(pid) == :ok
    assert Tram.doors_opened?(pid)
    assert Tram.stop!(pid) == :ok
    assert Tram.stop!(pid) == :ok
  end

  test "open_doors! / close_doors!", %{pid: pid} do
    assert Tram.stopped?(pid)
    assert Tram.move!(pid) == :ok
    assert Tram.movement?(pid)
    assert Tram.move!(pid) == :ok

    assert Tram.open_doors!(pid) == :error
    assert Tram.close_doors!(pid) == :ok
    refute Tram.doors_opened?(pid)
    assert Tram.movement?(pid)

    assert Tram.stop!(pid) == :ok
    assert Tram.stopped?(pid)
    refute Tram.doors_opened?(pid)
    assert Tram.open_doors!(pid) == :ok
    assert Tram.doors_opened?(pid)
    assert Tram.open_doors!(pid) == :ok

    assert Tram.move!(pid) == :error

    assert Tram.close_doors!(pid) == :ok
    assert Tram.close_doors!(pid) == :ok
    refute Tram.doors_opened?(pid)
  end
end

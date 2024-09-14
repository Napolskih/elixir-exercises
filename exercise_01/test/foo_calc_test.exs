defmodule FooCalcTest do
  use ExUnit.Case
  doctest FooCalc

  test "division" do
    assert FooCalc.division(10, 5) == 2
  end
end

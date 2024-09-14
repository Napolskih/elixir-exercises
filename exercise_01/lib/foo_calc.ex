defmodule FooCalc do
  @moduledoc """
  Documentation for `FooCalc`.
  """

  @spec add(integer | float, integer | float) :: :integer | float
  @doc """
  Adds two numbers.

  ## Examples

      iex> FooCalc.add(2, 3)
      5

      iex> FooCalc.add(2.1, 3.3)
      5.4

  """
  def add(a, b) do
    a + b
  end

  @spec subtract(integer | float, integer | float) :: :integer | float
  @doc """
  Subtracts one number from another.

  ## Examples

      iex> FooCalc.subtract(5, 3)
      2

      iex> FooCalc.subtract(2, 3)
      -1

  """
  def subtract(a, b) do
    a - b
  end

  @spec multiply(integer | float, integer | float) :: :integer | float
  @doc """
  Multiplies two numbers.

  ## Examples

      iex> FooCalc.multiply(5, 3)
      15

      iex> FooCalc.multiply(-2, 3)
      -6

  """
  def multiply(a, b) do
    a * b
  end

  @default_division_precision 2

  @spec division(integer | float, integer | float, integer) :: :integer | float
  @spec division(integer | float, integer | float) :: :integer | float
  @doc """
  Divides one number by another.
  Rounds to the specified precision, by default @default_division_precision = 2.

  ## Examples

      iex> FooCalc.division(5, 3)
      1.67

      iex> FooCalc.division(-2, 3)
      -0.67

      iex> FooCalc.division(-2, 3, 1)
      -0.7

  """

  def division(a, b, precision \\ @default_division_precision) do
    Float.round(a / b, precision)
  end
end

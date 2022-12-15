defmodule Day1 do
  @moduledoc """
  Solution for day 1 of advent of code
  """

  @doc """
  Read lines in chunks seperated by blank line.
    ## Examples

      iex> "1000\\n2000\\n3000\\n\\n4000\\n\\n5000\\n6000" |> Day1.group_input()
      [[1000, 2000, 3000], [4000], [5000, 6000]]
  """
  def group_input(input) do
    to_int = fn y -> String.to_integer(y) end

    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn x -> Enum.map(String.split(x, "\n", trim: true), to_int) end)
  end

  @doc """
  Get n largest of a list
    ## Examples

      iex> [6000, 12000, 8000, 4000, 10000, 1000, 2000] |> Day1.largest_n(3)
      [12000, 10000, 8000]

  """
  def largest_n(input, n) do
    input
    |> Enum.sort(&>=/2)
    |> Enum.take(n)
  end

  @doc """
    Find elve with most calories.
    Sum up the chunks and find largest
    ## Examples

      iex> "1000\\n2000\\n3000\\n\\n4000\\n\\n5000\\n6000" |> Day1.most_calories()
      11000

  """
  def most_calories(input) do
    input
    |> group_input()
    |> Enum.map(fn x -> Enum.sum(x) end)
    |> Enum.max()
  end

  @doc """
    Find n elves with most calories.
  """
  def most_calories(input, n) do
    input
    |> group_input()
    |> Enum.map(fn x -> Enum.sum(x) end)
    |> largest_n(n)
    |> Enum.sum()
  end

  def main(args) do
    {options, _, _} = OptionParser.parse(args, strict: [part: :integer])

    case options do
      [part: 1] -> most_calories(Input.get_input()) |> IO.inspect()
      _ -> most_calories(Input.get_input(), 3) |> IO.inspect()
    end
  end
end

defmodule Day4 do
  @moduledoc """
  Documentation for Day4.
  """

  @doc """
  Parse assignment pairs

  ## Examples

      iex> "2-4,6-8\\n2-3,4-5\\n" |> Day4.parse_assignments()
      [[{2, 4}, {6, 8}], [{2, 3}, {4, 5}]]

  """
  def parse_assignments(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.split(y, "-", trim: true) end) end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> Enum.map(y, &String.to_integer/1) end) end)
    |> Enum.map(fn x -> Enum.map(x, &List.to_tuple/1) end)
  end

  @doc """
  Assignment contains other
  Check if one assigment fully contains the other

  ## Examples

      iex> [{2, 8}, {3, 7}] |> Day4.contains_assignments()
      true
      iex> [{3, 7}, {2, 8}] |> Day4.contains_assignments()
      true
      iex> [{5, 7}, {7, 9}] |> Day4.contains_assignments()
      false
      iex> [{2, 4}, {6, 8}] |> Day4.contains_assignments()
      false

  """
  def contains_assignments([{min_1, max_1}, {min_2, max_2}])
      when min_2 >= min_1 and max_2 <= max_1 do
    true
  end

  def contains_assignments([{min_1, max_1}, {min_2, max_2}])
      when min_1 >= min_2 and max_1 <= max_2 do
    true
  end

  def contains_assignments(x) do
    false
  end

  def count_fully_overlapping_assignments(input) do
    input
    |> parse_assignments()
    |> Enum.map(&Day4.contains_assignments/1)
    |> Enum.count(&(&1 == true))
  end

  def main(args) do
    {options, _, _} = OptionParser.parse(args, strict: [part: :integer])

    case options do
      [part: 1] -> count_fully_overlapping_assignments(Input.get_input()) |> IO.inspect()
      _ -> false
    end
  end
end

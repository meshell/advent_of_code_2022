defmodule Day3 do
  @moduledoc """
  Documentation for Day3.
  """

  @doc """
  Parse input

  ## Examples

      iex> "vJrwpWtwJgWrhcsFMMfFFhFp\\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL" |> Day3.parse()
      ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"]

  """
  def parse(input) do
    input
    |> String.split("\n", trim: true)
  end

  @doc """
  Split rucksack contents into compartments

  ## Examples

      iex> "vJrwpWtwJgWrhcsFMMfFFhFp" |> Day3.split_rucksack()
      {"vJrwpWtwJgWr", "hcsFMMfFFhFp"}

  """
  def split_rucksack(content) do
    content
    |> String.split_at(trunc(String.length(content) / 2))
  end

  @doc """
  Find shared element

  ## Examples

      iex> {"vJrwpWtwJgWr", "hcsFMMfFFhFp"} |> Day3.shared_elements()
      ["p"]

  """
  def shared_elements({first, second}) do
    MapSet.intersection(MapSet.new(String.graphemes(first)), MapSet.new(String.graphemes(second)))
    |> MapSet.to_list()
  end

  @doc """
  Return priority

  ## Examples

      iex> "p" |> Day3.priority()
      16
      iex> "L" |> Day3.priority()
      38

  """
  def priority(item) when item >= "a" and item <= "z" do
    <<c::utf8>> = item
    c - ?a + 1
  end

  def priority(item) when item >= "A" and item <= "Z" do
    <<c::utf8>> = item
    c - ?A + 27
  end

  def priority_sum(input) do
    input
    |> parse()
    |> Enum.map(fn x -> split_rucksack(x) end)
    |> Enum.map(fn x -> shared_elements(x) end)
    |> List.flatten()
    |> Enum.reduce(0, fn x, acc -> priority(x) + acc end)
  end

  @doc """
  Group rucksack contents into groups of three

  ## Examples

      iex> "vJrwpWtwJgWrhcsFMMfFFhFp\\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\\nPmmdzqPrVvPwwTWBwg\\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\\nttgJtRGJQctTZtZT\\nCrZsJsPPZsGzwwsLwLmpwMDw" |> Day3.group_rucksacks()
      [["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg"], ["wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"]]

  """
  def group_rucksacks(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
  end

  @doc """
  Group rucksack contents into groups of three

  ## Examples

      iex> ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg"] |> Day3.find_common_item()
      ["r"]

  """
  def find_common_item([rucksack_1, rucksack_2, rucksack_3]) do
    MapSet.intersection(
      MapSet.new(String.graphemes(rucksack_1)),
      MapSet.new(String.graphemes(rucksack_2))
    )
    |> MapSet.intersection(MapSet.new(String.graphemes(rucksack_3)))
    |> MapSet.to_list()
  end

  def badge_priority_sum(input) do
    input
    |> group_rucksacks()
    |> Enum.map(fn x -> find_common_item(x) end)
    |> List.flatten()
    |> Enum.reduce(0, fn x, acc -> priority(x) + acc end)
  end

  def main(args) do
    {options, _, _} = OptionParser.parse(args, strict: [part: :integer])

    case options do
      [part: 1] -> priority_sum(Input.get_input()) |> IO.inspect()
      _ -> badge_priority_sum(Input.get_input()) |> IO.inspect()
    end
  end
end

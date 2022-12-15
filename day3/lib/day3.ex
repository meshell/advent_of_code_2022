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

  def main(_args) do
    priority_sum(Input.get_input())
    |> IO.inspect()
  end
end

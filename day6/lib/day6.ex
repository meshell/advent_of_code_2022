defmodule Day6 do
  @moduledoc """
  Documentation for Day6.
  """

  def find_marker_window({x, []}) do
    {x, []}
  end

  def find_marker_window({x, y}) do
    [h | tail] = y

    if length(Enum.take(y, 4)) == length(Enum.uniq(Enum.take(y, 4))) do
      {x ++ Enum.take(y, 4), []}
    else
      {x ++ [h], tail}
    end
  end

  @doc """
  Find start-of-packet marker.
  The start of a packet is indicated by a sequence of four characters that are all different.

  ## Examples

      iex> "mjqjpqmgbljsphdztnvjfqwrcgsmlb" |> Day6.find_marker()
      7
      iex> "bvwbjplbgvbhsrlpgdmjqwftvncz" |> Day6.find_marker()
      5
      iex> "nppdvjthqldpwncqszvftbrmjlhg" |> Day6.find_marker()
      6
      iex> "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" |> Day6.find_marker()
      10
      iex> "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" |> Day6.find_marker()
      11
  """
  def find_marker(input) do
    input_list =
      input
      |> String.codepoints()

    input_list
    |> Enum.reduce({[], input_list}, fn _, acc -> find_marker_window(acc) end)
    |> (fn {x, _} -> length(x) end).()
  end

  def main(args) do
    find_marker(Input.get_input())
    |> IO.inspect()
  end
end

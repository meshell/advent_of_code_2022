defmodule Day6 do
  @moduledoc """
  Documentation for Day6.
  """
  def find_marker_window({x, []}, m) do
    {x, []}
  end

  def find_marker_window({x, y}, m) do
    [h | tail] = y

    n =
      if m == :start_of_message do
        14
      else
        4
      end

    if length(Enum.take(y, n)) == length(Enum.uniq(Enum.take(y, n))) do
      {x ++ Enum.take(y, n), []}
    else
      {x ++ [h], tail}
    end
  end

  @doc """
  Find start-of-packet marker.
  The start of a packet is indicated by a sequence of four characters that are all different.

  ## Examples

      iex> "mjqjpqmgbljsphdztnvjfqwrcgsmlb" |> Day6.find_marker(:start_of_packet)
      7
      iex> "bvwbjplbgvbhsrlpgdmjqwftvncz" |> Day6.find_marker(:start_of_packet)
      5
      iex> "nppdvjthqldpwncqszvftbrmjlhg" |> Day6.find_marker(:start_of_packet)
      6
      iex> "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" |> Day6.find_marker(:start_of_packet)
      10
      iex> "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" |> Day6.find_marker(:start_of_packet)
      11
      iex> "mjqjpqmgbljsphdztnvjfqwrcgsmlb" |> Day6.find_marker(:start_of_message)
      19
  """
  def find_marker(input, m) do
    input_list =
      input
      |> String.codepoints()

    input_list
    |> Enum.reduce({[], input_list}, fn _, acc -> find_marker_window(acc, m) end)
    |> (fn {x, _} -> length(x) end).()
  end

  def main(args) do
    {options, _, _} = OptionParser.parse(args, strict: [part: :integer])

    case options do
      [part: 1] -> find_marker(Input.get_input(), :start_of_packet)
      _ -> find_marker(Input.get_input(), :start_of_message)
    end
    |> IO.inspect()
  end
end

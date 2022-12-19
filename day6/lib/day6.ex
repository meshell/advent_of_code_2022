defmodule Day6 do
  @moduledoc """
  Documentation for Day6.
  """

  def find_marker({x, y}, :start_of_message) do
    find_marker({x, y}, 14)
  end

  def find_marker({x, y}, :start_of_packet) do
    find_marker({x, y}, 4)
  end

  def find_marker({marker, remaining_input}, n) do
    if length(Enum.take(remaining_input, n)) == length(Enum.uniq(Enum.take(remaining_input, n))) do
      length(marker) + n
    else
      [h | tail] = remaining_input
      find_marker({marker ++ [h], tail}, n)
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
    {[]}
    |> Tuple.append(String.codepoints(input))
    |> find_marker(m)
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

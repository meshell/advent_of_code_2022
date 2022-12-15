defmodule Day2 do
  @moduledoc """
  Documentation for Day2.
  """

  def encode("A"), do: :rock
  def encode("B"), do: :paper
  def encode("C"), do: :scissors

  def encode("X"), do: :lose
  def encode("Y"), do: :draw
  def encode("Z"), do: :win

  def rock_paper_scissors(:rock, :scissors), do: :lose
  def rock_paper_scissors(:scissors, :rock), do: :win
  def rock_paper_scissors(:scissors, :paper), do: :lose
  def rock_paper_scissors(:paper, :scissors), do: :win
  def rock_paper_scissors(:paper, :rock), do: :lose
  def rock_paper_scissors(:rock, :paper), do: :win
  def rock_paper_scissors(_opponent, _me), do: :draw

  def score(:rock), do: 1
  def score(:paper), do: 2
  def score(:scissors), do: 3

  def score(:win), do: 6
  def score(:draw), do: 3
  def score(:lose), do: 0

  def give_hand(:rock, :win), do: :paper
  def give_hand(:paper, :win), do: :scissors
  def give_hand(:scissors, :win), do: :rock

  def give_hand(:rock, :lose), do: :scissors
  def give_hand(:paper, :lose), do: :rock
  def give_hand(:scissors, :lose), do: :paper
  def give_hand(shape, :draw), do: shape

  def score(shape, result) do
    score(shape) + score(result)
  end

  @doc """
    Play according strategy guide and return score
    ## Examples

      test "Strategy input A Y gives me 4 points" do
    assert Day2.play(["A", "Y"]) == 4
  end

    iex> ["A", "Y"] |> Day2.play()
    4
    iex> ["B", "X"] |> Day2.play()
    1
    iex> ["C", "Z"] |> Day2.play()
    7
  """
  def play([opponent, game_result]) do
    opponents_shape = encode(opponent)
    my_shape = give_hand(opponents_shape, encode(game_result))
    score(my_shape, rock_paper_scissors(opponents_shape, my_shape))
  end

  @doc """
    Read strategy guide
    ## Examples

    iex> "A Y\\nB X\\nC Z" |> Day2.parse()
    [["A", "Y"], ["B", "X"], ["C", "Z"]]
  """
  def parse(input) do
    input
    |> String.trim("\n")
    |> String.split("\n")
    |> Enum.map(fn x -> String.split(x, " ") end)
  end

  @doc """
    Caclulate total score from strategy guide:
    - Rock = +1
    - Paper = +2
    - Scissors = +3
    - Win = +6
    - Draw = +3
    - Lose = +0

    ## Examples

    iex> "A Y\\nB X\\nC Z" |> Day2.total_score()
    12
  """
  def total_score(input) do
    input
    |> parse()
    |> Enum.map(fn x -> play(x) end)
    |> List.foldl(0, fn x, acc -> x + acc end)
  end

  def main(_args) do
    total_score(Input.get_input())
    |> IO.inspect()
  end
end

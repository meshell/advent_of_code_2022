defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "Rock defeats Scissors: When opponent plays Scissors and I play Rock then I lose" do
    assert Day2.rock_paper_scissors(:rock, :scissors) == :lose
  end

  test "Rock defeats Scissors: When opponent plays Rock and I play Scissors then I win" do
    assert Day2.rock_paper_scissors(:scissors, :rock) == :win
  end

  test "Scissors defeats Paper: When opponent plays Scissors and I play Paper then I lose" do
    assert Day2.rock_paper_scissors(:scissors, :paper) == :lose
  end

  test "Scissors defeats Paper: When opponent plays Paper and I play Scissors then I win" do
    assert Day2.rock_paper_scissors(:paper, :scissors) == :win
  end

  test "Paper defeats Rock: When opponent plays Paper and I play Rock then I lose" do
    assert Day2.rock_paper_scissors(:paper, :rock) == :lose
  end

  test "Paper defeats Rock: When opponent plays Rock and I play Paper then I win" do
    assert Day2.rock_paper_scissors(:rock, :paper) == :win
  end

  test "When same shape than is draw" do
    assert Day2.rock_paper_scissors(:rock, :rock) == :draw
    assert Day2.rock_paper_scissors(:scissors, :scissors) == :draw
    assert Day2.rock_paper_scissors(:paper, :paper) == :draw
  end

  test "Strategy input A is Rock" do
    assert Day2.encode("A") == :rock
  end

  test "Strategy input X is lose" do
    assert Day2.encode("X") == :lose
  end

  test "Strategy input B is Paper" do
    assert Day2.encode("B") == :paper
  end

  test "Strategy input Y is draw" do
    assert Day2.encode("Y") == :draw
  end

  test "Strategy input C is Scissors " do
    assert Day2.encode("C") == :scissors
  end

  test "Strategy input Z is win" do
    assert Day2.encode("Z") == :win
  end

  test "Winning when Rock means playing Paper" do
    assert Day2.give_hand(:rock, :win) == :paper
  end

  test "Winning when Paper means playing Scissors" do
    assert Day2.give_hand(:paper, :win) == :scissors
  end

  test "Winning when Scissors means playing Rock" do
    assert Day2.give_hand(:scissors, :win) == :rock
  end

  test "Loosing when Rock means playing Scissors" do
    assert Day2.give_hand(:rock, :lose) == :scissors
  end

  test "Loosing when Paper means playing Rock" do
    assert Day2.give_hand(:paper, :lose) == :rock
  end

  test "Loosing when Scissors means playing Paper" do
    assert Day2.give_hand(:scissors, :lose) == :paper
  end

  test "For drawplay same" do
    assert Day2.give_hand(:rock, :draw) == :rock
    assert Day2.give_hand(:paper, :draw) == :paper
    assert Day2.give_hand(:scissors, :draw) == :scissors
  end

  test "Shape Rock gives 1 point" do
    assert Day2.score(:rock) == 1
  end

  test "Shape Paper gives 2 points" do
    assert Day2.score(:paper) == 2
  end

  test "Shape Paper gives 3 points" do
    assert Day2.score(:scissors) == 3
  end

  test "Winning gives 6 points" do
    assert Day2.score(:win) == 6
  end

  test "Loosing gives 0 points" do
    assert Day2.score(:lose) == 0
  end

  test "A draw gives 3 points" do
    assert Day2.score(:draw) == 3
  end

  test "Winning with Rock gives 7 point" do
    assert Day2.score(:rock, :win) == 7
  end
end

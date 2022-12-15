defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "Count assignment pairs that do fully contain the other range" do
    input = """
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    """

    assert Day4.count_fully_overlapping_assignments(input) == 2
  end

  test "Count overlapping assignment pairs" do
    input = """
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    """

    assert Day4.count_overlapping_assignments(input) == 4
  end
end

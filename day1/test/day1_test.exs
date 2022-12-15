defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "total calories of the top 3 elves" do
    input = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """

    assert Day1.most_calories(input, 3) == 45000
  end
end

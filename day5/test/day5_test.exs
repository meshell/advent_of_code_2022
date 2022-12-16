defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "Separation of stack drawing and rearrangement procedure" do
    input = """
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    drawing = """
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3
    """

    procedures = """
    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    assert Day5.parse(input) == [String.trim(drawing, "\n"), procedures]
  end

  test "rearrangement procedure once" do
    start_stack = [["N", "Z"], ["D", "C", "M"], ["P"]]

    procedure = "move 1 from 2 to 1"

    assert Day5.rearrange_once(start_stack, Day5.parse_rearrangement_procedure(procedure)) == [
             ["D", "N", "Z"],
             ["C", "M"],
             ["P"]
           ]
  end

  test "rearrangement procedures" do
    start_stack = [["N", "Z"], ["D", "C", "M"], ["P"]]

    procedures = """
    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    assert Day5.rearrange(start_stack, procedures, :cratemover9000) == [
             ["C"],
             ["M"],
             ["Z", "N", "D", "P"]
           ]
  end

  test "get top of stack" do
    stack_drawing = """
            [Z]
            [N]
            [D]
    [C] [M] [P]
    """

    assert Day5.top_of_stacks(Day5.parse_stack_drawing(stack_drawing)) == "CMZ"
  end

  test "get top of rearrange stack" do
    input = """
        [D]
    [N] [C]
    [Z] [M] [P]
    1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    assert Day5.get_top_of_rearrange_stack(input) == "CMZ"
  end

  test "get top of rearrange stack with CrateMover 9001" do
    input = """
        [D]
    [N] [C]
    [Z] [M] [P]
    1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    assert Day5.get_top_of_rearrange_stack(input, :cratemover9001) == "MCD"
  end
end

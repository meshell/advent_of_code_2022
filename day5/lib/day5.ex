defmodule Day5 do
  @moduledoc """
  Documentation for Day5.
  """

  @doc """
  Separate Stack drawing from rearrangement procedure

  """
  def parse(input) do
    input
    |> String.split("\n\n", trim: true)
  end

  @doc """
  Parse the rearrangement procedure
    ## Examples

      iex> "move 1 from 2 to 1" |> Day5.parse_rearrangement_procedure()
      {1, 2, 1}
      iex> "move 11 from 2 to 1" |> Day5.parse_rearrangement_procedure()
      {11, 2, 1}
  """
  def parse_rearrangement_procedure(procedures) do
    procedures
    |> String.replace(["move", "from", "to"], "")
    |> String.split(" ", trim: true)
    |> Enum.reject(&(&1 == " "))
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> List.to_tuple()
  end

  @doc """
  Parse the rearrangement procedures
    ## Examples

      iex> "move 1 from 2 to 1\\nmove 3 from 1 to 3\\nmove 2 from 2 to 1\\nmove 1 from 1 to 2\\n" |> Day5.parse_rearrangement_procedures()
      [{1, 2, 1}, {3, 1, 3}, {2, 2, 1}, {1, 1, 2}]
  """
  def parse_rearrangement_procedures(procedures) do
    procedures
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_rearrangement_procedure/1)
  end

  @doc """
  Parse the stack drawing
    ## Examples

      iex> "    [D]\\n[N] [C]\\n[Z] [M] [P]\\n1   2   3" |> Day5.parse_stack_drawing()
      [["N", "Z"], ["D", "C", "M"], ["P"]]
  """
  def parse_stack_drawing(stack) do
    stack_levels =
      stack
      |> String.split("\n")
      |> Enum.map(&String.codepoints/1)
      |> Enum.map(fn x -> Enum.chunk_every(x, 4) end)
      |> Enum.map(fn x ->
        Enum.map(x, fn y ->
          Enum.filter(y, fn z ->
            z != " " and z != "[" and z != "]" and Integer.parse(z) == :error
          end)
        end)
      end)

    max_len = stack_levels |> Enum.map(&length(&1)) |> Enum.max()

    stack_levels
    |> Enum.map(fn x -> x ++ List.duplicate(nil, max_len - length(x)) end)
    |> Enum.zip()
    |> Enum.map(fn x -> x |> Tuple.to_list() |> Enum.reject(fn y -> y == nil or y == [] end) end)
    |> Enum.map(&List.flatten/1)
  end

  @doc """
  Rearrange the stack with one rearrangement procedure
    ## Examples

      iex> [["N", "Z"], ["D", "C", "M"], ["P"]] |> Day5.rearrange_once({1, 2, 1})
      [["D", "N", "Z"], ["C", "M"], ["P"]]
  """
  def rearrange_once(stack, {no_item, from, to}) do
    [new_from_stack, new_to_stack] =
      move_from_to(no_item, Enum.at(stack, from - 1), Enum.at(stack, to - 1))

    stack
    |> List.update_at(from - 1, &(&1 = new_from_stack))
    |> List.update_at(to - 1, &(&1 = new_to_stack))
  end

  @doc """
  Rearrange the stack
  """
  def rearrange(stack, procedures) do
    parse_rearrangement_procedures(procedures)
    |> List.foldl(stack, fn p, s -> rearrange_once(s, p) end)
  end

  @doc """
  Move n elements from one stack to other
    ## Examples

      iex> Day5.move_from_to(1, ["D", "C", "M"], ["N", "Z"])
      [["C", "M"], ["D", "N", "Z"]]

      iex> Day5.move_from_to(2, ["D", "C", "M"], ["N", "Z"])
      [["M"], ["C", "D", "N", "Z"]]
  """
  def move_from_to(0, from, to) do
    [from, to]
  end

  def move_from_to(n, [head | tail], to) when n > 0 do
    move_from_to(n - 1, tail, [head | to])
  end

  @doc """
  Get the top of the stacks
    ## Examples

      iex> [["C"], ["M"], ["Z", "N", "D", "P"]] |> Day5.top_of_stacks()
      "CMZ"
  """
  def top_of_stacks(stack) do
    stack
    |> Enum.reduce("", fn [h | t], acc -> acc <> h end)
  end

  def get_top_of_rearrange_stack(input) do
    [stack, procedures] = parse(input)

    rearrange(parse_stack_drawing(stack), procedures)
    |> top_of_stacks()
  end

  def main(args) do
    {options, _, _} = OptionParser.parse(args, strict: [part: :integer])

    case options do
      _ ->
        get_top_of_rearrange_stack(Input.get_input())
    end
    |> IO.inspect()
  end
end

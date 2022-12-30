defmodule Day7 do
  @moduledoc """
  Documentation for Day7.
  """

  @doc """
  Split a multiline terminal output into groups of commans and its output

  """
  def dir_sizes(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.reject(&(&1 == "$ ls" || match?("dir " <> _, &1)))
    |> Stream.concat(Stream.repeatedly(fn -> "$ cd .." end))
    |> Stream.transform(
      [{0, ""}],
      fn
        "$ cd ..", [_last] ->
          {:halt, nil}

        "$ cd ..", [{size, name}, {parent_size, parent_name} | stack] ->
          {[{size, name}], [{parent_size + size, parent_name} | stack]}

        "$ cd " <> "/", [h | stack] ->
          {[], [{0, "/"} | [h | stack]]}

        "$ cd " <> dir_name, [h | stack] ->
          h
          |> (fn
                {_size, "/"} ->
                  {[], [{0, "/" <> dir_name} | [h | stack]]}

                {_size, parent_name} ->
                  {[], [{0, parent_name <> "/" <> dir_name} | [h | stack]]}
              end).()

        file_entry, [{size, name} | stack] ->
          [filesize, _filename] = String.split(file_entry, " ")
          {[], [{size + String.to_integer(filesize), name} | stack]}
      end
    )
  end

  def find_dir_smaller(dir_sizes, size) do
    dir_sizes
    |> Stream.filter(fn {dir_size, _} -> dir_size <= size end)
  end

  def calculate_sum_of_dir_smaller(input, size) do
    input
    |> dir_sizes()
    |> find_dir_smaller(size)
    |> Enum.to_list()
    |> Enum.reduce(0, fn {dir_size, _}, acc -> acc + dir_size end)
  end

  def main(args) do
    {options, _, _} = OptionParser.parse(args, strict: [part: :integer])

    case options do
      _ -> calculate_sum_of_dir_smaller(Input.get_input(), 100_000)
    end
    |> IO.inspect()
  end
end

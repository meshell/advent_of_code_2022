defmodule Day7Test do
  use ExUnit.Case
  doctest Day7

  test "get list of dir with total size" do
    input = """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """

    assert Day7.dir_sizes(input) |> Enum.to_list() == [
             {584, "/a/e"},
             {94853, "/a"},
             {24_933_642, "/d"},
             {48_381_165, "/"}
           ]
  end

  test "get list of dir smaller then 100000" do
    input = """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """

    assert Day7.dir_sizes(input) |> Day7.find_dir_smaller(100_000) |> Enum.to_list() == [
             {584, "/a/e"},
             {94853, "/a"}
           ]
  end

  test "calculate total size (sum) of all directories smaller then 100000" do
    input = """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """

    assert Day7.calculate_sum_of_dir_smaller(input, 100_000) == 95437
  end
end

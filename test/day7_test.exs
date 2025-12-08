defmodule Day7Test do
  use ExUnit.Case

  @input """
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

  test "building filesystem" do
    {fs, _} = Day7.build_from(@input)
    assert length(fs) == 4
  end

  test "directory size computation" do
    {fs, _} = Day7.build_from(@input)
    assert Day7.dir_size(fs, "/a") == 94_853
    assert Day7.dir_size(fs, "/a/e") == 584
    assert Day7.dir_size(fs, "/d") == 24_933_642
    assert Day7.dir_size(fs, "/") == 48_381_165
  end

  test "part 1" do
    assert Day7.part1() == 1_086_293
  end

  test "part 2" do
    assert Day7.part2() == 366_028
  end
end

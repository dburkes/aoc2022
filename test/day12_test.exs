defmodule Day12Test do
  use ExUnit.Case

  @input """
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
  """

  test "parsing" do
    {grid, start, target} = Day12.parse(@input)

    assert start == {0, 0}
    assert target == {2, 5}
    assert Map.get(grid, {0, 0}) == ?a
    assert Map.get(grid, {2, 5}) == ?z
  end

  test "shortest path from example" do
    {grid, start, target} = Day12.parse(@input)
    assert Day12.shortest_path(grid, start, target) == 31
  end

  test "find all elevations" do
    {grid, _start, _target} = Day12.parse(@input)
    a_positions = Day12.find_all_elevations(grid, ?a)
    # The starting 'S' is converted to 'a', plus other 'a's in the grid
    assert length(a_positions) == 6
  end

  test "part 1" do
    assert Day12.part1() == 481
  end

  test "part 2" do
    assert Day12.part2() == 480
  end
end

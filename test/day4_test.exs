defmodule Day4Test do
  use ExUnit.Case

  @input """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
  """

  test "parsing" do
    assignments = Day4.parse(@input)

    assert assignments == [
             [2..4, 6..8],
             [2..3, 4..5],
             [5..7, 7..9],
             [2..8, 3..7],
             [6..6, 4..6],
             [2..6, 4..8]
           ]
  end

  test "part1" do
    assert Day4.part1() == 550
  end

  test "part2" do
    assert Day4.part2() == 931
  end
end

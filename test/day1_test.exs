defmodule Day1Test do
  use ExUnit.Case

  @input """
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

  test "parsing" do
    assert Day1.parse(@input) == [6000, 4000, 11000, 24000, 10000]
  end

  test "part1" do
    assert Day1.part1() == 70374
  end

  test "part2" do
    assert Day1.part2() == 204_610
  end
end

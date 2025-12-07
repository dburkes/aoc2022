defmodule Day6Test do
  use ExUnit.Case

  test "marker finding" do
    assert Day6.find_marker("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert Day6.find_marker("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert Day6.find_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert Day6.find_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end

  test "part1" do
    assert Day6.part1() == 1480
  end
end

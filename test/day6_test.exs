defmodule Day6Test do
  use ExUnit.Case

  describe "finding" do
    test "packet markers" do
      assert Day6.find_marker("bvwbjplbgvbhsrlpgdmjqwftvncz", :packet) == 5
      assert Day6.find_marker("nppdvjthqldpwncqszvftbrmjlhg", :packet) == 6
      assert Day6.find_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", :packet) == 10
      assert Day6.find_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", :packet) == 11
    end

    test "message markers" do
      assert Day6.find_marker("mjqjpqmgbljsphdztnvjfqwrcgsmlb", :message) == 19
      assert Day6.find_marker("bvwbjplbgvbhsrlpgdmjqwftvncz", :message) == 23
      assert Day6.find_marker("nppdvjthqldpwncqszvftbrmjlhg", :message) == 23
      assert Day6.find_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", :message) == 29
      assert Day6.find_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", :message) == 26
    end
  end

  test "part1" do
    assert Day6.part1() == 1480
  end

  test "part2" do
    assert Day6.part2() == 2746
  end
end

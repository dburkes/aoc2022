defmodule Day15Test do
  use ExUnit.Case

  @input """
  Sensor at x=2, y=18: closest beacon is at x=-2, y=15
  Sensor at x=9, y=16: closest beacon is at x=10, y=16
  Sensor at x=13, y=2: closest beacon is at x=15, y=3
  Sensor at x=12, y=14: closest beacon is at x=10, y=16
  Sensor at x=10, y=20: closest beacon is at x=10, y=16
  Sensor at x=14, y=17: closest beacon is at x=10, y=16
  Sensor at x=8, y=7: closest beacon is at x=2, y=10
  Sensor at x=2, y=0: closest beacon is at x=2, y=10
  Sensor at x=0, y=11: closest beacon is at x=2, y=10
  Sensor at x=20, y=14: closest beacon is at x=25, y=17
  Sensor at x=17, y=20: closest beacon is at x=21, y=22
  Sensor at x=16, y=7: closest beacon is at x=15, y=3
  Sensor at x=14, y=3: closest beacon is at x=15, y=3
  Sensor at x=20, y=1: closest beacon is at x=15, y=3
  """

  test "parsing" do
    pairs = Day15.parse(@input)
    assert length(pairs) == 14

    assert pairs == [
             {{2, 18}, {-2, 15}},
             {{9, 16}, {10, 16}},
             {{13, 2}, {15, 3}},
             {{12, 14}, {10, 16}},
             {{10, 20}, {10, 16}},
             {{14, 17}, {10, 16}},
             {{8, 7}, {2, 10}},
             {{2, 0}, {2, 10}},
             {{0, 11}, {2, 10}},
             {{20, 14}, {25, 17}},
             {{17, 20}, {21, 22}},
             {{16, 7}, {15, 3}},
             {{14, 3}, {15, 3}},
             {{20, 1}, {15, 3}}
           ]
  end

  describe "range splitting" do
    test "mid-range" do
      assert Day15.split_range_with_exclusion(5..10, 8) == [5..7, 9..10]
    end

    test "head of range" do
      assert Day15.split_range_with_exclusion(5..10, 5) == [6..10]
    end

    test "tail of range" do
      assert Day15.split_range_with_exclusion(5..10, 10) == [5..9]
    end

    test "out of range" do
      assert Day15.split_range_with_exclusion(5..10, 14) == [5..10]
    end

    test "entire range" do
      assert Day15.split_range_with_exclusion(2..2, 2) == []
    end
  end

  describe "calculating exclusions" do
    test "for a single pair" do
      assert Day15.exclusions_for({{8, 7}, {2, 10}}, -2) == [8..8]
      assert Day15.num_exclusions_for({{8, 7}, {2, 10}}, -2) == 1

      assert Day15.exclusions_for({{8, 7}, {2, 10}}, -1) == [7..9]
      assert Day15.num_exclusions_for({{8, 7}, {2, 10}}, -1) == 3

      assert Day15.exclusions_for({{8, 7}, {2, 10}}, 7) == [-1..17]
      assert Day15.num_exclusions_for({{8, 7}, {2, 10}}, 7) == 19

      assert Day15.exclusions_for({{8, 7}, {2, 10}}, 10) == [3..14]
      assert Day15.num_exclusions_for({{8, 7}, {2, 10}}, 10) == 12
    end

    test "for multiple pairs" do
      pairs = Day15.parse(@input)
      assert Day15.all_exclusions_for(pairs, 10) == 26
    end
  end

  test "part 1" do
    assert Day15.part1() == 4_876_693
  end
end

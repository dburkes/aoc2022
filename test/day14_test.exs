defmodule Day14Test do
  use ExUnit.Case

  @input """
  498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9
  """

  test "parsing" do
    {rocks, max_y} = Day14.parse(@input)
    assert MapSet.size(rocks) == 20

    assert MapSet.member?(rocks, {498, 4})
    assert MapSet.member?(rocks, {498, 5})
    assert MapSet.member?(rocks, {498, 6})
    assert MapSet.member?(rocks, {497, 6})
    assert MapSet.member?(rocks, {496, 6})
    assert MapSet.member?(rocks, {502, 4})
    assert MapSet.member?(rocks, {503, 4})
    assert MapSet.member?(rocks, {502, 5})
    assert MapSet.member?(rocks, {502, 6})
    assert MapSet.member?(rocks, {502, 7})
    assert MapSet.member?(rocks, {502, 8})
    assert MapSet.member?(rocks, {502, 9})
    assert MapSet.member?(rocks, {501, 9})
    assert MapSet.member?(rocks, {500, 9})
    assert MapSet.member?(rocks, {499, 9})
    assert MapSet.member?(rocks, {498, 9})
    assert MapSet.member?(rocks, {497, 9})
    assert MapSet.member?(rocks, {496, 9})
    assert MapSet.member?(rocks, {495, 9})
    assert MapSet.member?(rocks, {494, 9})

    assert max_y == 9
  end

  test "block detection" do
    {rocks, _} = Day14.parse(@input)
    assert Day14.blocked?({498, 4}, rocks)
    assert Day14.blocked?({498, 5}, rocks)
    assert Day14.blocked?({498, 6}, rocks)
    assert Day14.blocked?({497, 6}, rocks)
    assert Day14.blocked?({496, 6}, rocks)
    assert Day14.blocked?({502, 4}, rocks)
    assert Day14.blocked?({503, 4}, rocks)
    assert Day14.blocked?({502, 5}, rocks)
    assert Day14.blocked?({502, 6}, rocks)
    assert Day14.blocked?({502, 7}, rocks)
    assert Day14.blocked?({502, 8}, rocks)
    assert Day14.blocked?({502, 9}, rocks)
    assert Day14.blocked?({501, 9}, rocks)
    assert Day14.blocked?({500, 9}, rocks)
    assert Day14.blocked?({499, 9}, rocks)
    assert Day14.blocked?({498, 9}, rocks)
    assert Day14.blocked?({497, 9}, rocks)
    assert Day14.blocked?({496, 9}, rocks)
    assert Day14.blocked?({495, 9}, rocks)
    assert Day14.blocked?({494, 9}, rocks)
    refute Day14.blocked?({493, 9}, rocks)
  end

  describe "flowing a single grain of sand" do
    test "stops when blocked" do
      {rocks, max_y} = Day14.parse(@input)
      {x, y} = Day14.flow_grain(rocks, max_y)
      assert x == 500
      assert y == 8
    end

    test "stops when it reaches infinite flow" do
      {rocks, max_y} = Day14.parse(@input)
      rocks = MapSet.delete(rocks, {500, 9})
      {x, y} = Day14.flow_grain(rocks, max_y)
      assert x == 500
      assert y == 9
    end
  end

  describe("flowing multiple grains of sand") do
    test "stops when infinite flow is achieved" do
      {rocks, max_y} = Day14.parse(@input)
      assert Day14.max_grains(rocks, max_y, :infinite) == 24
    end

    test "stops when the source is blocked" do
      {rocks, max_y} = Day14.parse(@input)
      assert Day14.max_grains(rocks, max_y, :blocked) == 93
    end
  end

  test "part 1" do
    assert Day14.part1() == 674
  end

  test "part 2" do
    assert Day14.part2() == 24958
  end
end

defmodule Day13Test do
  use ExUnit.Case

  @input """
  [1,1,3,1,1]
  [1,1,5,1,1]

  [[1],[2,3,4]]
  [[1],4]

  [9]
  [[8,7,6]]

  [[4,4],4,4]
  [[4,4],4,4,4]

  [7,7,7,7]
  [7,7,7]

  []
  [3]

  [[[]]]
  [[]]

  [1,[2,[3,[4,[5,6,7]]]],8,9]
  [1,[2,[3,[4,[5,6,0]]]],8,9]
  """

  @sorted_input [
    [],
    [[]],
    [[[]]],
    [1, 1, 3, 1, 1],
    [1, 1, 5, 1, 1],
    [[1], [2, 3, 4]],
    [1, [2, [3, [4, [5, 6, 0]]]], 8, 9],
    [1, [2, [3, [4, [5, 6, 7]]]], 8, 9],
    [[1], 4],
    [[2]],
    [3],
    [[4, 4], 4, 4],
    [[4, 4], 4, 4, 4],
    [[6]],
    [7, 7, 7],
    [7, 7, 7, 7],
    [[8, 7, 6]],
    [9]
  ]

  test "parsing" do
    data = Day13.parse(@input)

    assert is_map(data)
    assert length(Map.keys(data)) == 8

    {l, r} = Map.get(data, 1)
    assert l == [1, 1, 3, 1, 1]
    assert r == [1, 1, 5, 1, 1]
  end

  describe "comparing two integers" do
    test "where left < right" do
      assert Day13.compare(3, 4) == :lt
    end

    test "where left == right" do
      assert Day13.compare(3, 3) == :eq
    end

    test "where left > right" do
      assert Day13.compare(4, 3) == :gt
    end
  end

  describe "comaring two lists" do
    test "when the lists are the same length" do
      assert Day13.compare([1, 2, 3], [4, 5, 6]) == :lt
      assert Day13.compare([1, 2, 3], [0, 1, 6]) == :gt
      assert Day13.compare([1, 2, 3], [1, 2, 3]) == :eq
    end

    test "when the left list has fewer members than the right list" do
      assert Day13.compare([1, 2], [4, 5, 6]) == :lt
      assert Day13.compare([1, 2], [1, 2, 6]) == :lt
      assert Day13.compare([1, 2], [1, 2, 3]) == :lt
    end

    test "when the right list has fewer members than the left list" do
      assert Day13.compare([1, 2, 3, 4], [4, 5, 6]) == :lt
      assert Day13.compare([1, 2, 3, 4], [4, 1, 6]) == :lt
      assert Day13.compare([[[]]], [[]]) == :gt
    end
  end

  describe "comparing a list and an integer" do
    test "when the left item is an integer" do
      assert Day13.compare(1, [2]) == :lt
      assert Day13.compare(4, [2, 3]) == :gt
      assert Day13.compare(1, [1]) == :eq
    end

    test "when the left item is a list" do
      assert Day13.compare([1], 2) == :lt
      assert Day13.compare([2], 1) == :gt
      assert Day13.compare([1, 2, 3], 4) == :lt
      assert Day13.compare([4], 4) == :eq
    end
  end

  test "comparing complex terms" do
    assert Day13.compare([[1], [2, 3, 4]], [[1], 4]) == :lt

    assert Day13.compare([1, [2, [3, [4, [5, 6, 7]]]], 8, 9], [1, [2, [3, [4, [5, 6, 0]]]], 8, 9]) ==
             :gt
  end

  test "example comparisons" do
    assert Day13.compare([1, 1, 3, 1, 1], [1, 1, 5, 1, 1]) == :lt
    assert Day13.compare([[1], [2, 3, 4]], [[1], 4]) == :lt
    assert Day13.compare([9], [[8, 7, 6]]) == :gt
    assert Day13.compare([[4, 4], 4, 4], [[4, 4], 4, 4, 4]) == :lt
    assert Day13.compare([7, 7, 7, 7], [7, 7, 7]) == :gt
    assert Day13.compare([], [3]) == :lt
    assert Day13.compare([[[]]], [[]]) == :gt

    assert Day13.compare([1, [2, [3, [4, [5, 6, 7]]]], 8, 9], [1, [2, [3, [4, [5, 6, 0]]]], 8, 9]) ==
             :gt
  end

  test "scoring" do
    assert Day13.score(Day13.parse(@input)) == 13
  end

  test "sorting" do
    assert Day13.sort_packets(Day13.parse(@input)) == @sorted_input
  end

  test "finding decoder key" do
    assert Day13.find_decoder_key(Day13.parse(@input)) == 140
  end

  test "part 1" do
    assert Day13.part1() == 5843
  end

  test "part 2" do
    assert Day13.part2() == 26289
  end
end

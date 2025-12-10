defmodule Day9Test do
  use ExUnit.Case

  @input """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  test "parsing" do
    moves = Day9.parse(@input)
    assert length(moves) == 8
    assert Enum.at(moves, 0) == {:R, 4}
    assert Enum.at(moves, 3) == {:D, 1}
    assert Enum.at(moves, 7) == {:R, 2}
  end

  describe "single moves" do
    test "with H above and to the left of T" do
      h = {0, 0}
      t = {1, 1}

      assert Day9.move(h, t, :L) == {{0, -1}, {0, 0}}
      assert Day9.move(h, t, :R) == {{0, 1}, {1, 1}}
      assert Day9.move(h, t, :U) == {{-1, 0}, {0, 0}}
      assert Day9.move(h, t, :D) == {{1, 0}, {1, 1}}
    end

    test "with H above T" do
      h = {0, 0}
      t = {1, 0}

      assert Day9.move(h, t, :L) == {{0, -1}, {1, 0}}
      assert Day9.move(h, t, :R) == {{0, 1}, {1, 0}}
      assert Day9.move(h, t, :U) == {{-1, 0}, {0, 0}}
      assert Day9.move(h, t, :D) == {{1, 0}, {1, 0}}
    end

    test "with H above and to the right of T" do
      h = {0, 1}
      t = {1, 0}

      assert Day9.move(h, t, :L) == {{0, 0}, {1, 0}}
      assert Day9.move(h, t, :R) == {{0, 2}, {0, 1}}
      assert Day9.move(h, t, :U) == {{-1, 1}, {0, 1}}
      assert Day9.move(h, t, :D) == {{1, 1}, {1, 0}}
    end

    test "with H to the left of T" do
      h = {0, 0}
      t = {0, 1}

      assert Day9.move(h, t, :L) == {{0, -1}, {0, 0}}
      assert Day9.move(h, t, :R) == {{0, 1}, {0, 1}}
      assert Day9.move(h, t, :U) == {{-1, 0}, {0, 1}}
      assert Day9.move(h, t, :D) == {{1, 0}, {0, 1}}
    end

    test "with H and T coincident" do
      h = {0, 0}
      t = {0, 0}

      assert Day9.move(h, t, :L) == {{0, -1}, {0, 0}}
      assert Day9.move(h, t, :R) == {{0, 1}, {0, 0}}
      assert Day9.move(h, t, :U) == {{-1, 0}, {0, 0}}
      assert Day9.move(h, t, :D) == {{1, 0}, {0, 0}}
    end

    test "with H to the right of T" do
      h = {0, 1}
      t = {0, 0}

      assert Day9.move(h, t, :L) == {{0, 0}, {0, 0}}
      assert Day9.move(h, t, :R) == {{0, 2}, {0, 1}}
      assert Day9.move(h, t, :U) == {{-1, 1}, {0, 0}}
      assert Day9.move(h, t, :D) == {{1, 1}, {0, 0}}
    end

    test "with H below and to the left of T" do
      h = {1, 0}
      t = {0, 1}

      assert Day9.move(h, t, :L) == {{1, -1}, {1, 0}}
      assert Day9.move(h, t, :R) == {{1, 1}, {0, 1}}
      assert Day9.move(h, t, :U) == {{0, 0}, {0, 1}}
      assert Day9.move(h, t, :D) == {{2, 0}, {1, 0}}
    end

    test "with H below and to the right of T" do
      h = {1, 1}
      t = {0, 0}

      assert Day9.move(h, t, :L) == {{1, 0}, {0, 0}}
      assert Day9.move(h, t, :R) == {{1, 2}, {1, 1}}
      assert Day9.move(h, t, :U) == {{0, 1}, {0, 0}}
      assert Day9.move(h, t, :D) == {{2, 1}, {1, 1}}
    end
  end

  test "single moves with multiple knots" do
    {h, t, visits} = Day9.move_with_knots([{:R, 6}], 5)
    assert h == {0, 6}
    assert t == {0, 2}
    assert MapSet.size(visits) == 3
  end

  describe "multiple moves" do
    test "with two knots" do
      moves = Day9.parse(@input)
      {h, t, tail_visits} = Day9.move_with_knots(moves, 2)
      assert h == {-2, 2}
      assert t == {-2, 1}
      assert MapSet.size(tail_visits) == 13
    end

    test "with ten knots" do
      moves = Day9.parse(@input)
      {_, _, tail_visits} = Day9.move_with_knots(moves, 10)
      assert MapSet.size(tail_visits) == 1
    end
  end

  test "part 1" do
    assert Day9.part1() == 6486
  end

  test "part 2" do
    assert Day9.part2() == 2678
  end
end

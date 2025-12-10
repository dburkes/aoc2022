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
      ht = {{0, 0}, {1, 1}}

      assert Day9.move(ht, :L) == {{0, -1}, {0, 0}}
      assert Day9.move(ht, :R) == {{0, 1}, {1, 1}}
      assert Day9.move(ht, :U) == {{-1, 0}, {0, 0}}
      assert Day9.move(ht, :D) == {{1, 0}, {1, 1}}
    end

    test "with H above T" do
      ht = {{0, 0}, {1, 0}}

      assert Day9.move(ht, :L) == {{0, -1}, {1, 0}}
      assert Day9.move(ht, :R) == {{0, 1}, {1, 0}}
      assert Day9.move(ht, :U) == {{-1, 0}, {0, 0}}
      assert Day9.move(ht, :D) == {{1, 0}, {1, 0}}
    end

    test "with H above and to the right of T" do
      ht = {{0, 1}, {1, 0}}

      assert Day9.move(ht, :L) == {{0, 0}, {1, 0}}
      assert Day9.move(ht, :R) == {{0, 2}, {0, 1}}
      assert Day9.move(ht, :U) == {{-1, 1}, {0, 1}}
      assert Day9.move(ht, :D) == {{1, 1}, {1, 0}}
    end

    test "with H to the left of T" do
      ht = {{0, 0}, {0, 1}}

      assert Day9.move(ht, :L) == {{0, -1}, {0, 0}}
      assert Day9.move(ht, :R) == {{0, 1}, {0, 1}}
      assert Day9.move(ht, :U) == {{-1, 0}, {0, 1}}
      assert Day9.move(ht, :D) == {{1, 0}, {0, 1}}
    end

    test "with H and T coincident" do
      ht = {{0, 0}, {0, 0}}

      assert Day9.move(ht, :L) == {{0, -1}, {0, 0}}
      assert Day9.move(ht, :R) == {{0, 1}, {0, 0}}
      assert Day9.move(ht, :U) == {{-1, 0}, {0, 0}}
      assert Day9.move(ht, :D) == {{1, 0}, {0, 0}}
    end

    test "with H to the right of T" do
      ht = {{0, 1}, {0, 0}}

      assert Day9.move(ht, :L) == {{0, 0}, {0, 0}}
      assert Day9.move(ht, :R) == {{0, 2}, {0, 1}}
      assert Day9.move(ht, :U) == {{-1, 1}, {0, 0}}
      assert Day9.move(ht, :D) == {{1, 1}, {0, 0}}
    end

    test "with H below and to the left of T" do
      ht = {{1, 0}, {0, 1}}

      assert Day9.move(ht, :L) == {{1, -1}, {1, 0}}
      assert Day9.move(ht, :R) == {{1, 1}, {0, 1}}
      assert Day9.move(ht, :U) == {{0, 0}, {0, 1}}
      assert Day9.move(ht, :D) == {{2, 0}, {1, 0}}
    end

    test "with H below T" do
      ht = {{1, 0}, {0, 0}}

      assert Day9.move(ht, :L) == {{1, -1}, {0, 0}}
      assert Day9.move(ht, :R) == {{1, 1}, {0, 0}}
      assert Day9.move(ht, :U) == {{0, 0}, {0, 0}}
      assert Day9.move(ht, :D) == {{2, 0}, {1, 0}}
    end

    test "with H below and to the right of T" do
      ht = {{1, 1}, {0, 0}}

      assert Day9.move(ht, :L) == {{1, 0}, {0, 0}}
      assert Day9.move(ht, :R) == {{1, 2}, {1, 1}}
      assert Day9.move(ht, :U) == {{0, 1}, {0, 0}}
      assert Day9.move(ht, :D) == {{2, 1}, {1, 1}}
    end
  end

  test "multiple moves" do
    moves = Day9.parse(@input)
    {{h, t}, tail_visits} = Day9.make_moves(moves, {{4, 0}, {4, 0}})
    assert h == {2, 2}
    assert t == {2, 1}
    assert MapSet.size(tail_visits) == 13
  end

  test "part 1" do
    assert Day9.part1() == 6486
  end
end

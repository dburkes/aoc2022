defmodule Day5Test do
  use ExUnit.Case

  @input """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  test "parsing" do
    {stacks, moves} = Day5.parse(@input)
    assert stacks == ["ZN", "MCD", "P"]
    assert moves == [{1, 2, 1}, {3, 1, 3}, {2, 2, 1}, {1, 1, 2}]
  end

  describe "single moves" do
    test "one crate at a time" do
      {stacks, moves} = Day5.parse(@input)
      stacks = Day5.move(stacks, Enum.at(moves, 0), :single)
      assert stacks == ["ZND", "MC", "P"]
      stacks = Day5.move(stacks, Enum.at(moves, 1), :single)
      assert stacks == ["", "MC", "PDNZ"]
    end

    test "multiple crates at a time" do
      {stacks, moves} = Day5.parse(@input)
      stacks = Day5.move(stacks, Enum.at(moves, 0), :multiple)
      assert stacks == ["ZND", "MC", "P"]
      stacks = Day5.move(stacks, Enum.at(moves, 1), :multiple)
      assert stacks == ["", "MC", "PZND"]
    end
  end

  describe "multiple moves" do
    test "one crate at a time" do
      {stacks, moves} = Day5.parse(@input)
      stacks = Day5.move(stacks, moves, :single)
      assert stacks == ["C", "M", "PDNZ"]
    end

    test "multiple crates at a time" do
      {stacks, moves} = Day5.parse(@input)
      stacks = Day5.move(stacks, moves, :multiple)
      assert stacks == ["M", "C", "PZND"]
    end
  end

  test "ending message" do
    assert Day5.message(Day5.parse(@input), :single) == "CMZ"
    assert Day5.message(Day5.parse(@input), :multiple) == "MCD"
  end

  test "part 1" do
    assert Day5.part1() == "RNZLFZSJH"
  end

  test "part 2" do
    assert Day5.part2() == "CNSFCGJSM"
  end
end

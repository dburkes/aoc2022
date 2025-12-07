defmodule Day3Test do
  use ExUnit.Case

  @input """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  test "parsing" do
    sacks = Day3.parse(@input)

    assert length(sacks) == 6

    assert String.length(elem(Enum.at(sacks, 0), 0)) == 12
    assert String.length(elem(Enum.at(sacks, 0), 1)) == 12

    assert String.length(elem(Enum.at(sacks, 1), 0)) == 16
    assert String.length(elem(Enum.at(sacks, 1), 1)) == 16

    assert String.length(elem(Enum.at(sacks, 2), 0)) == 9
    assert String.length(elem(Enum.at(sacks, 2), 1)) == 9

    assert String.length(elem(Enum.at(sacks, 3), 0)) == 15
    assert String.length(elem(Enum.at(sacks, 3), 1)) == 15

    assert String.length(elem(Enum.at(sacks, 4), 0)) == 8
    assert String.length(elem(Enum.at(sacks, 4), 1)) == 8

    assert String.length(elem(Enum.at(sacks, 5), 0)) == 12
    assert String.length(elem(Enum.at(sacks, 5), 1)) == 12
  end

  test "finding common item" do
    sacks = Day3.parse(@input)

    assert Day3.find_common_item(Enum.at(sacks, 0)) == "p"
    assert Day3.find_common_item(Enum.at(sacks, 1)) == "L"
    assert Day3.find_common_item(Enum.at(sacks, 2)) == "P"
    assert Day3.find_common_item(Enum.at(sacks, 3)) == "v"
    assert Day3.find_common_item(Enum.at(sacks, 4)) == "t"
    assert Day3.find_common_item(Enum.at(sacks, 5)) == "s"
  end

  test "priority" do
    assert Day3.priority("a") == 1
    assert Day3.priority("m") == 13
    assert Day3.priority("A") == 27
    assert Day3.priority("M") == 39
  end

  test "part1" do
    assert Day3.part1() == 7817
  end
end

defmodule Day2Test do
  use ExUnit.Case

  @input """
  A Y
  B X
  C Z
  """

  test "parsing" do
    assert Day2.parse_rounds(@input) == [
             ["A", "Y"],
             ["B", "X"],
             ["C", "Z"]
           ]
  end

  test "scoring" do
    assert Day2.score("A", "Y") == 8
    assert Day2.score("B", "X") == 1
    assert Day2.score("C", "Z") == 6
  end

  test "play_for" do
    assert Day2.play_for("A", "X") == "Z"
    assert Day2.play_for("A", "Y") == "X"
    assert Day2.play_for("A", "Z") == "Y"
    assert Day2.play_for("B", "X") == "X"
    assert Day2.play_for("B", "Y") == "Y"
    assert Day2.play_for("B", "Z") == "Z"
    assert Day2.play_for("C", "X") == "Y"
    assert Day2.play_for("C", "Y") == "Z"
    assert Day2.play_for("C", "Z") == "X"
  end

  test "part1" do
    assert Day2.part1() == 12458
  end

  test "part2" do
    assert Day2.part2() == 12683
  end
end

defmodule Day8Test do
  use ExUnit.Case

  @input """
  30373
  25512
  65332
  33549
  35390
  """

  test "parsing" do
    forest = Day8.parse(@input)

    assert map_size(forest) == 25
    assert Map.get(forest, {0, 0}) == 3
    assert Map.get(forest, {1, 3}) == 1
    assert Map.get(forest, {4, 2}) == 3
  end

  test "visibiity" do
    forest = Day8.parse(@input)

    assert Day8.visible?(forest, {0, 0}) == true
    assert Day8.visible?(forest, {0, 1}) == true
    assert Day8.visible?(forest, {0, 2}) == true

    assert Day8.visible?(forest, {1, 1}) == true
    assert Day8.visible?(forest, {1, 2}) == true
    assert Day8.visible?(forest, {1, 3}) == false

    assert Day8.visible?(forest, {2, 1}) == true
    assert Day8.visible?(forest, {2, 2}) == false
    assert Day8.visible?(forest, {2, 3}) == true

    assert Day8.visible?(forest, {3, 1}) == false
    assert Day8.visible?(forest, {3, 2}) == true
    assert Day8.visible?(forest, {3, 3}) == false

    assert Day8.visible?(forest, {4, 0}) == true
    assert Day8.visible?(forest, {4, 1}) == true
    assert Day8.visible?(forest, {4, 2}) == true
  end

  test "counting visible trees in forest" do
    forest = Day8.parse(@input)
    assert Day8.visible_count(forest) == 21
  end

  test "visibility_score" do
    forest = Day8.parse(@input)

    assert Day8.visibility_score(forest, {1, 2}) |> elem(0) == 4
    assert Day8.visibility_score(forest, {3, 2}) |> elem(0) == 8
  end

  test "finding highest visibility score" do
    forest = Day8.parse(@input)
    assert Day8.max_visibility_score(forest) == {8, {3, 2}}
  end

  test "part 1" do
    assert Day8.part1() == 1719
  end

  test "part 2" do
    assert Day8.part2() == 590_824
  end
end

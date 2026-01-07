defmodule Day11Test do
  use ExUnit.Case

  @input """
  Monkey 0:
    Starting items: 79, 98
    Operation: new = old * 19
    Test: divisible by 23
      If true: throw to monkey 2
      If false: throw to monkey 3

  Monkey 1:
    Starting items: 54, 65, 75, 74
    Operation: new = old + 6
    Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

  Monkey 2:
    Starting items: 79, 60, 97
    Operation: new = old * old
    Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

  Monkey 3:
    Starting items: 74
    Operation: new = old + 3
    Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1
  """

  test "parsing" do
    monkey_data = Day11.parse(@input)
    assert length(Map.keys(monkey_data)) == 4

    monkey0 = Map.get(monkey_data, 0)

    assert Map.get(monkey0, :items) == [79, 98]
    assert Map.get(monkey0, :test) == 23
    assert Map.get(monkey0, :operation) == {:*, 19}
    assert Map.get(monkey0, true) == 2
    assert Map.get(monkey0, false) == 3
  end

  test "turn" do
    monkey_data = Day11.parse(@input)
    new_monkey_data = Day11.turn(monkey_data, 0, 3)

    new_monkey_0 = Map.get(new_monkey_data, 0)
    assert Map.get(new_monkey_0, :items) == []

    new_monkey_3 = Map.get(new_monkey_data, 3)
    assert Map.get(new_monkey_3, :items) == [74, 500, 620]
  end

  test "do_round" do
    monkey_data = Day11.parse(@input)
    new_monkey_data = Day11.do_round(monkey_data, 3)

    new_monkey_0 = Map.get(new_monkey_data, 0)
    assert Map.get(new_monkey_0, :items) == [20, 23, 27, 26]

    new_monkey_1 = Map.get(new_monkey_data, 1)
    assert Map.get(new_monkey_1, :items) == [2080, 25, 167, 207, 401, 1046]

    new_monkey_2 = Map.get(new_monkey_data, 2)
    assert Map.get(new_monkey_2, :items) == []

    new_monkey_3 = Map.get(new_monkey_data, 3)
    assert Map.get(new_monkey_3, :items) == []
  end

  test "do_rounds" do
    monkey_data = Day11.parse(@input)
    new_monkey_data = Day11.do_rounds(monkey_data, 20, 3)

    new_monkey_0 = Map.get(new_monkey_data, 0)
    assert Map.get(new_monkey_0, :items) == [10, 12, 14, 26, 34]
    assert Map.get(new_monkey_0, :inspections) == 101

    new_monkey_1 = Map.get(new_monkey_data, 1)
    assert Map.get(new_monkey_1, :items) == [245, 93, 53, 199, 115]
    assert Map.get(new_monkey_1, :inspections) == 95

    new_monkey_2 = Map.get(new_monkey_data, 2)
    assert Map.get(new_monkey_2, :items) == []
    assert Map.get(new_monkey_2, :inspections) == 7

    new_monkey_3 = Map.get(new_monkey_data, 3)
    assert Map.get(new_monkey_3, :items) == []
    assert Map.get(new_monkey_3, :inspections) == 105
  end

  test "monkey business" do
    monkey_data = Day11.parse(@input)
    assert Day11.monkey_business(monkey_data, 20, 3) == 10605
  end

  test "part 1" do
    assert Day11.part1() == 51075
  end

  test "part 2" do
    assert Day11.part2() == 11_741_456_163
  end
end

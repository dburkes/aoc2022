defmodule Day11 do
  def part1() do
    monkey_business(parse(), 20)
  end

  def monkey_business(monkey_data, num_rounds) do
    do_rounds(monkey_data, num_rounds)
    |> Map.values()
    |> Enum.into([], fn m -> Map.get(m, :inspections) end)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

  def do_rounds(monkey_data, num_rounds) do
    1..num_rounds
    |> Enum.reduce(monkey_data, fn _, data ->
      do_round(data)
    end)
  end

  def do_round(monkey_data) do
    Map.keys(monkey_data)
    |> Enum.reduce(monkey_data, fn monkey_id, monkeys ->
      turn(monkeys, monkey_id)
    end)
  end

  def turn(monkey_data, monkey_id) do
    this_monkey = Map.get(monkey_data, monkey_id)

    items = Map.get(this_monkey, :items)

    items
    |> Enum.reduce({monkey_data, this_monkey}, fn item, {monkeys, monkey} ->
      {operator, operand} = Map.get(monkey, :operation)

      worry_level =
        case operator do
          :* ->
            item * operand

          :+ ->
            item + operand

          :square ->
            item * item
        end

      worry_level = div(worry_level, 3)

      test = Map.get(monkey, :test)

      target_monkey_id =
        case rem(worry_level, test) do
          0 ->
            Map.get(monkey, true)

          _ ->
            Map.get(monkey, false)
        end

      updated_this_monkey =
        Map.update(monkey, :items, nil, fn items -> tl(items) end)
        |> Map.update(:inspections, 0, fn cnt -> cnt + 1 end)

      updated_target_monkey =
        Map.get(monkeys, target_monkey_id)
        |> Map.update(:items, nil, fn items -> items ++ [worry_level] end)

      updated_monkeys =
        Map.put(monkeys, monkey_id, updated_this_monkey)
        |> Map.put(target_monkey_id, updated_target_monkey)

      {updated_monkeys, updated_this_monkey}
    end)
    |> elem(0)
  end

  def parse(input \\ File.read!("lib/fixtures/day11.txt")) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.into(%{}, fn spec ->
      r =
        ~r/Monkey ([\d]+):.*items: ([\d, ]+).*new = old ([*+]) (\d+|old).* divisible by (\d+).* true: throw to monkey (\d+).* false: throw to monkey (\d+)/

      captures = Regex.run(r, String.replace(spec, "\n", ""), capture: :all_but_first)

      monkey_number =
        Enum.at(captures, 0)
        |> String.to_integer()

      items =
        Enum.at(captures, 1)
        |> String.split(",")
        |> Enum.map(fn n ->
          String.trim(n)
          |> String.to_integer()
        end)

      operand = Enum.at(captures, 3)

      operation =
        cond do
          operand == "old" ->
            {:square, nil}

          true ->
            {Enum.at(captures, 2) |> String.to_atom(), String.to_integer(operand)}
        end

      test =
        Enum.at(captures, 4)
        |> String.to_integer()

      true_op =
        Enum.at(captures, 5)
        |> String.to_integer()

      false_op =
        Enum.at(captures, 6)
        |> String.to_integer()

      {
        monkey_number,
        %{
          items: items,
          operation: operation,
          test: test,
          true: true_op,
          false: false_op,
          inspections: 0
        }
      }
    end)
  end
end

defmodule Day10 do
  def part1() do
    parse()
    |> signal_strength()
  end

  def part2() do
    parse()
    |> draw()
  end

  def draw(program) do
    history = run(program, 240) |> elem(2)
    1..240
    |> Enum.reduce("", fn cycle, screen ->
      screen <> draw(rem(cycle - 1, 40), register_during(cycle, history))
    end)
    |> then(fn s -> Regex.scan(~r/.{40}/, s) |> Enum.join("\n") end)
  end

  def draw(draw_position, sprite_position) do
    if (sprite_position in draw_position - 1..draw_position + 1), do: "#", else: "."
  end

  def signal_strength(program) do
    {_, _, history} = run(program)

    [20, 60, 100, 140, 180, 220]
    |> Enum.sum_by(fn cycle_number ->
      signal_strength(cycle_number, history)
    end)
  end

  def signal_strength(cycle, history), do: register_during(cycle, history) * cycle

  def register_during(cycle, history) do
    Enum.split_with(history, fn {cycle_num, _} -> cycle_num < cycle end)
    |> elem(0)
    |> List.last()
    |> then(fn r -> if (r == nil), do: 1, else: elem(r, 1) end)
  end

  def run(program, cycles \\ 1_000_000) do
    program
    |> Enum.reduce_while({0, 1, []}, fn {instruction, param}, {cycle_num, register, history} ->
      instruction_cycles =
        case(instruction) do
          :noop -> 1
          :addx -> 2
        end

      cond do
        cycle_num + instruction_cycles <= cycles ->
          new_reg = register + param
          new_cycle = cycle_num + instruction_cycles

          if new_cycle == cycles do
            {:halt, {cycles, new_reg, [{cycles, new_reg} | history]}}
          else
            {:cont, {new_cycle, new_reg, [{new_cycle, new_reg} | history]}}
          end

        true ->
          {:halt, {cycles, register, [{cycles, register} | history]}}
      end
    end)
    |> then(fn {cycles, register, history} -> {cycles, register, Enum.reverse(history)} end)
  end

  def parse(input \\ File.read!("lib/fixtures/day10.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction("noop"), do: {:noop, 0}
  defp parse_instruction("addx " <> value), do: {:addx, String.to_integer(value)}
end

defmodule Day5 do
  def part1() do
    parse()
    |> message(:single)
  end

  def part2() do
    parse()
    |> message(:multiple)
  end

  def message({stacks, moves}, mode) do
    move(stacks, moves, mode)
    |> Enum.map(&String.at(&1, -1))
    |> Enum.join()
  end

  def move(stacks, {count, from, to}, mode) do
    from_stack = List.pop_at(stacks, from - 1) |> elem(0)
    to_stack = List.pop_at(stacks, to - 1) |> elem(0)
    crates_to_move = String.slice(from_stack, -count, count)

    List.update_at(stacks, to - 1, fn _ ->
      case mode do
        :single ->
          to_stack <> String.reverse(crates_to_move)

        :multiple ->
          to_stack <> crates_to_move
      end
    end)
    |> List.update_at(from - 1, fn _ ->
      String.slice(from_stack, 0..-(count + 1)//1)
    end)
  end

  def move(stacks, moves, mode) do
    Enum.reduce(moves, stacks, fn move, acc ->
      move(acc, move, mode)
    end)
  end

  def parse(input \\ File.read!("lib/fixtures/day5.txt")) do
    [stacks_input, moves_input] = String.split(input, "\n\n", trim: false)
    {parse_stacks(stacks_input), parse_moves(moves_input)}
  end

  defp parse_stacks(stacks_input) do
    splits = String.split(stacks_input, "\n")
    stack_data = Enum.drop(splits, -1)
    num_cols = Enum.at(splits, -1) |> String.split() |> length()

    stacks = List.duplicate("", num_cols)

    stack_data
    |> Enum.reduce(stacks, fn line, acc ->
      String.split(line, ~r/(.{3}) /su, include_captures: true, trim: true)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {crate, index}, acc ->
        letter = String.at(crate, 1)

        case letter do
          " " ->
            acc

          _ ->
            List.update_at(acc, index, fn stack -> letter <> stack end)
        end
      end)
    end)
  end

  defp parse_moves(moves_input) do
    moves_input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [_, count, _, from, _, to] ->
      {String.to_integer(count), String.to_integer(from), String.to_integer(to)}
    end)
  end
end

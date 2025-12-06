defmodule Day1 do
  def part1() do
    parse()
    |> Enum.max()
  end

  def part2() do
    parse()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  def parse(input \\ File.read!("lib/fixtures/day1.txt")) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.chunk_while(
      [],
      fn
        "", acc -> {:cont, acc, []}
        num, acc -> {:cont, [String.to_integer(num) | acc]}
      end,
      &{:cont, &1, []}
    )
    |> Enum.map(&Enum.sum/1)
  end
end

defmodule Day1 do
  def part1() do
    parse(File.read!("lib/fixtures/day1.txt"))
    |> Enum.max()
  end

  def parse(input) do
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

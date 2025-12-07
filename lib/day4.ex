defmodule Day4 do
  def part1() do
    parse()
    |> Enum.filter(&redundant?/1)
    |> length
  end

  def part2() do
    parse()
    |> Enum.filter(&overlap?/1)
    |> length
  end

  def redundant?([a, b]) do
    contains?(a, b) or contains?(b, a)
  end

  def contains?(a, b) do
    Enum.min(a) >= Enum.min(b) and Enum.max(a) <= Enum.max(b)
  end

  def overlap?([a, b]), do: not Range.disjoint?(a, b)

  def parse(input \\ File.read!("lib/fixtures/day4.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&parse_assignments/1)
  end

  defp parse_assignments(ranges) do
    ranges
    |> Enum.map(fn r ->
      [start, end_] = String.split(r, "-")
      String.to_integer(start)..String.to_integer(end_)
    end)
  end
end

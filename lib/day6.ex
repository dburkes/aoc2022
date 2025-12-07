defmodule Day6 do
  def part1() do
    find_marker(File.read!("lib/fixtures/day6.txt"), :packet)
  end

  def part2() do
    find_marker(File.read!("lib/fixtures/day6.txt"), :message)
  end

  def find_marker(input, type) do
    offset =
      case type do
        :packet -> 4
        :message -> 14
      end

    input
    |> String.graphemes()
    |> Enum.chunk_every(offset, 1, :discard)
    |> Enum.find_index(fn chunk -> Enum.uniq(chunk) == chunk end)
    |> Kernel.+(offset)
  end
end

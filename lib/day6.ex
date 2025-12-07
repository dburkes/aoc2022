defmodule Day6 do
  def part1() do
    find_marker(File.read!("lib/fixtures/day6.txt"))
  end

  def find_marker(input) do
    input
    |> String.graphemes()
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.find_index(fn chunk -> Enum.uniq(chunk) == chunk end)
    |> Kernel.+(4)
  end
end

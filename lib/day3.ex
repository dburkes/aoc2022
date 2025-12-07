defmodule Day3 do
  def part1() do
    parse()
    |> Enum.map(&find_common_item/1)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  def find_common_item({left, right}) do
    left_chars = String.codepoints(left)
    right_chars = String.codepoints(right)

    Enum.find(left_chars, &Enum.member?(right_chars, &1))
  end

  def priority(item) do
    if String.upcase(item) == item do
      hd(String.to_charlist(item)) - ?A + 27
    else
      hd(String.to_charlist(item)) - ?a + 1
    end
  end

  def parse(input \\ File.read!("lib/fixtures/day3.txt")) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      halfs = String.split_at(line, div(String.length(line), 2))
      {elem(halfs, 0), elem(halfs, 1)}
    end)
  end
end

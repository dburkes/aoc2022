defmodule Day15 do
  def part1() do
    parse()
    |> all_exclusions_for(2_000_000)
    |> MapSet.size()
  end

  def all_exclusions_for(pairs, y) do
    pairs
    |> Enum.map(&exclusions_for(&1, y))
    |> Enum.reduce(MapSet.new(), &MapSet.union/2)
  end

  def exclusions_for({{sx, sy} = sensor, beacon}, y) do
    max_distance = distance(sensor, beacon) - abs(sy - y)

    if(max_distance < 0) do
      MapSet.new()
    else
      (sx - max_distance)..(sx + max_distance)
      |> Enum.reduce(MapSet.new(), fn x, acc -> MapSet.put(acc, {x, y}) end)
      |> MapSet.delete(beacon)
    end
  end

  def distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  def parse(input \\ File.read!("lib/fixtures/day15.txt")) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line ->
      Regex.scan(~r/[xy]=([-?\d]+)/, line)
      |> Enum.map(fn [_, n] -> String.to_integer(n) end)
    end)
    |> Enum.map(fn [x, y, x2, y2] ->
      {{x, y}, {x2, y2}}
    end)
  end
end

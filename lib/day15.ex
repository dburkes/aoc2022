defmodule Day15 do
  def part1() do
    parse()
    |> all_exclusions_for(2_000_000)
  end

  def all_exclusions_for(pairs, y) do
    pairs
    |> Enum.map(&exclusions_for(&1, y))
    |> Enum.reject(fn r -> r == nil end)
    |> List.flatten()
    |> Enum.sort()
    |> Enum.map(&Range.to_list/1)
    |> List.flatten()
    |> Enum.uniq()
    |> length()
  end

  def num_exclusions_for(pair, y) do
    exclusions_for(pair, y)
    |> Enum.sum_by(&Range.size/1)
  end

  def exclusions_for({{sx, sy} = sensor, {bx, by} = beacon}, y) do
    max_distance = distance(sensor, beacon) - abs(sy - y)

    if(max_distance < 0) do
      nil
    else
      if by == y do
        r = (sx - max_distance)..(sx + max_distance)
        split_range_with_exclusion(r, bx)
      else
        [(sx - max_distance)..(sx + max_distance)]
      end
    end
  end

  def split_range_with_exclusion(r, ex) do
    first..last//1 = r

    if ex in r do
      cond do
        ex == first and ex == last ->
          []

        ex == first ->
          [(first + 1)..last//1]

        ex == last ->
          [first..(last - 1)//1]

        true ->
          [first..(ex - 1)//1, (ex + 1)..last//1]
      end
    else
      [r]
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

defmodule Day15 do
  def part1() do
    parse()
    |> num_exclusions_for(2_000_000)
  end

  def part2() do
    parse()
    |> find_distress_beacon(4_000_000)
    |> then(fn {x, y} -> x * 4_000_000 + y end)
  end

  def find_distress_beacon(pairs, max_xy) do
    0..max_xy
    |> Enum.reduce_while(0, fn row, _ ->
      bounded_exclusions = all_exclusions_for(pairs, row, false)

      case length(bounded_exclusions) > 1 do
        true ->
          {:halt, {Enum.at(bounded_exclusions, 0).last + 1, row}}

          false ->
            {:cont, 0}
          end
    end)
  end

  def num_exclusions_for(pairs, y, exclude_beacons \\ true) do
    all_exclusions_for(pairs, y, exclude_beacons)
    |> Enum.sum_by(&Range.size/1)
  end

  def all_exclusions_for(pairs, y, exclude_beacons \\ true) do
    pairs
    |> Enum.flat_map(&exclusions_for(&1, y, exclude_beacons))
    |> merge_ranges()
  end

  def exclusions_for({{sx, sy} = sensor, {bx, by} = beacon}, y, exclude_beacons \\ true) do
    max_distance = distance(sensor, beacon) - abs(sy - y)

    if(max_distance < 0) do
      []
    else
      if by == y do
        if exclude_beacons
          do
            split_range_with_exclusion((sx - max_distance)..(sx + max_distance), bx)
            else
              [(sx - max_distance)..(sx + max_distance)]
          end
      else
        [(sx - max_distance)..(sx + max_distance)]
      end
    end
  end

  def merge_ranges(ranges) do
    Enum.sort(ranges)
    |> Enum.reduce([], fn current_range, merged_acc ->
      case merged_acc do
        [] -> [current_range]
        [last_merged | rest] ->
          if last_merged.last >= current_range.first - 1 do
            [(last_merged.first..max(last_merged.last, current_range.last))] ++ rest
          else
            [current_range | merged_acc]
          end
      end
    end)
    |> Enum.reverse()
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

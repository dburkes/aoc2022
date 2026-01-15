defmodule Day14 do
  def part1() do
    {rocks, max_y} = parse()
    max_grains(rocks, max_y)
  end

  def max_grains(rocks, max_y) do
    flow(rocks, max_y, MapSet.new())
  end

  def flow(rocks, max_y, grains) do
    {x, y} = flow_grain(MapSet.union(rocks, grains), max_y)
    if y < max_y, do: flow(rocks, max_y, MapSet.put(grains, {x, y})), else: MapSet.size(grains)
  end

  def flow_grain(obstacles, max_y, {x, y} \\ {500, 0}) do
    if y == max_y do
      {x, y}
    else
      if blocked?({x, y + 1}, obstacles) do
        if blocked?({x - 1, y + 1}, obstacles) do
          if blocked?({x + 1, y + 1}, obstacles) do
            {x, y}
          else
            flow_grain(obstacles, max_y, {x + 1, y + 1})
          end
        else
          flow_grain(obstacles, max_y, {x - 1, y + 1})
        end
      else
        flow_grain(obstacles, max_y, {x, y + 1})
      end
    end
  end

  def blocked?({x, y}, obstacles) do
    MapSet.member?(obstacles, {x, y})
  end

  def parse(data \\ File.read!("lib/fixtures/day14.txt")) do
    data
    |> String.split("\n", trim: true)
    |> Enum.reduce({MapSet.new(), 0}, fn line, {rocks, max_y} ->
      line
      |> String.split(" -> ")
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce({rocks, max_y}, fn [p1, p2], {rocks, max_y} ->
        [x1, y1] = String.split(p1, ",") |> Enum.map(&String.to_integer/1)
        [x2, y2] = String.split(p2, ",") |> Enum.map(&String.to_integer/1)

        rocks =
          for x <- min(x1, x2)..max(x1, x2),
              y <- min(y1, y2)..max(y1, y2),
              into: rocks,
              do: {x, y}

        {rocks, max(max_y, max(y1, y2))}
      end)
    end)
  end
end

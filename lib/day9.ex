defmodule Day9 do
  def part1 do
    parse()
    |> make_moves({{0, 0}, {0, 0}})
    |> elem(1)
    |> MapSet.size()
  end

  def make_moves(moves, start) do
    tail_visits = MapSet.new() |> MapSet.put(elem(start, 1))

    moves
    |> Enum.reduce({start, tail_visits}, fn {dir, num}, acc ->
      Enum.reduce(1..num, {acc, dir}, fn _, {{pos, tail_visits}, dir} ->
        new_pos = move(pos, dir)
        {{new_pos, MapSet.put(tail_visits, elem(new_pos, 1))}, dir}
      end)
      |> elem(0)
    end)
  end

  def step_head({r, c}, :R), do: {r, c + 1}
  def step_head({r, c}, :L), do: {r, c - 1}
  def step_head({r, c}, :U), do: {r - 1, c}
  def step_head({r, c}, :D), do: {r + 1, c}

  def step_tail({hr, hc}, {tr, tc}) when abs(hr - tr) <= 1 and abs(hc - tc) <= 1, do: {tr, tc}
  def step_tail({tr, hc}, {tr, tc}) when hc - tc > 0, do: {tr, tc + 1}
  def step_tail({tr, hc}, {tr, tc}) when hc - tc < 0, do: {tr, tc - 1}
  def step_tail({hr, tc}, {tr, tc}) when hr - tr > 0, do: {tr + 1, tc}
  def step_tail({hr, tc}, {tr, tc}) when hr - tr < 0, do: {tr - 1, tc}

  def step_tail({hr, hc}, {tr, tc}) do
    dr = if hr - tr > 0, do: 1, else: -1
    dc = if hc - tc > 0, do: 1, else: -1
    {tr + dr, tc + dc}
  end

  def move({h, t}, dir) do
    h = step_head(h, dir)
    {h, step_tail(h, t)}
  end

  def(parse(input \\ File.read!("lib/fixtures/day9.txt"))) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [direction, steps] ->
      {String.to_atom(direction), String.to_integer(steps)}
    end)
  end
end

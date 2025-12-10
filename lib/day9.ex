defmodule Day9 do
  defmodule Rope do
    defstruct head: {0, 0},
              tail: {0, 0},
              knots: [],
              visited: MapSet.new([{0, 0}])
  end

  def part1 do
    parse()
    |> move_with_knots(2)
    |> then(fn {_, _, visited} -> MapSet.size(visited) end)
  end

  def part2 do
    parse()
    |> move_with_knots(10)
    |> then(fn {_, _, visited} -> MapSet.size(visited) end)
  end

  def move_with_knots(moves, knot_count) do
    knots =
      cond do
        knot_count > 2 ->
          for(_ <- 3..knot_count, do: {0, 0})

        true ->
          []
      end

    moves
    |> Enum.reduce(%Rope{knots: knots}, &make_moves/2)
    |> then(fn %Rope{head: h, tail: t, visited: visited} -> {h, t, visited} end)
  end

  def make_moves({_, 0}, rope), do: rope

  def make_moves({dir, amount}, rope) do
    head = step_head(rope.head, dir)

    {knots, leader} =
      Enum.map_reduce(rope.knots, head, fn knot, leader ->
        new_knot = step_tail(leader, knot)
        {new_knot, new_knot}
      end)

    tail = step_tail(leader, rope.tail)
    visited = MapSet.put(rope.visited, tail)
    make_moves({dir, amount - 1}, %Rope{head: head, tail: tail, knots: knots, visited: visited})
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

  def move(h, t, dir) do
    h = step_head(h, dir)
    {h, step_tail(h, t)}
  end

  def parse(input \\ File.read!("lib/fixtures/day9.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [direction, steps] ->
      {String.to_atom(direction), String.to_integer(steps)}
    end)
  end
end

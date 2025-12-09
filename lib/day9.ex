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
        new_pos = move(pos, {dir, 1})
        {{new_pos, MapSet.put(tail_visits, elem(new_pos, 1))}, dir}
      end)
      |> elem(0)
    end)
  end

  # H above and to the left of T
  #
  def move({{hr, hc}, {tr, tc}}, {dir, num}) when hr == tr - 1 and hc == tc - 1 and num == 1 do
    case dir do
      :L ->
        {{hr, hc - 1}, {hr, hc}}

      :R ->
        {{hr, hc + 1}, {tr, tc}}

      :U ->
        {{hr - 1, hc}, {hr, hc}}

      :D ->
        {{hr + 1, hc}, {tr, tc}}
    end
  end

  # H above T
  #
  def move({{hr, hc}, {tr, tc}}, {dir, num}) when hr == tr - 1 and hc == tc and num == 1 do
    case dir do
      :L ->
        {{hr, hc - 1}, {tr, tc}}

      :R ->
        {{hr, hc + 1}, {tr, tc}}

      :U ->
        {{hr - 1, hc}, {tr - 1, tc}}

      :D ->
        {{hr + 1, hc}, {tr, tc}}
    end
  end

  # H above and to the right of T
  #
  def move({{hr, hc}, {tr, tc}}, {dir, num}) when hr == tr - 1 and hc == tc + 1 and num == 1 do
    case dir do
      :L ->
        {{hr, hc - 1}, {tr, tc}}

      :R ->
        {{hr, hc + 1}, {hr, hc}}

      :U ->
        {{hr - 1, hc}, {hr, hc}}

      :D ->
        {{hr + 1, hc}, {tr, tc}}
    end
  end

  # H to the left of T
  #
  def move({{hr, hc}, {tr, tc}}, {dir, num}) when hr == tr and hc == tc - 1 and num == 1 do
    case dir do
      :L ->
        {{hr, hc - 1}, {tr, tc - 1}}

      :R ->
        {{hr, hc + 1}, {tr, tc}}

      :U ->
        {{hr - 1, hc}, {tr, tc}}

      :D ->
        {{hr + 1, hc}, {tr, tc}}
    end
  end

  # H and T coincident
  #
  def move({h, t}, {dir, num}) when h == t and num == 1 do
    {hr, hc} = h

    case dir do
      :L ->
        {{hr, hc - 1}, t}

      :R ->
        {{hr, hc + 1}, t}

      :U ->
        {{hr - 1, hc}, t}

      :D ->
        {{hr + 1, hc}, t}
    end
  end

  # H to the right of T
  #
  def move({{hr, hc}, {tr, tc}}, {dir, num}) when hr == tr and hc == tc + 1 and num == 1 do
    case dir do
      :L ->
        {{hr, hc - 1}, {tr, tc}}

      :R ->
        {{hr, hc + 1}, {tr, tc + 1}}

      :U ->
        {{hr - 1, hc}, {tr, tc}}

      :D ->
        {{hr + 1, hc}, {tr, tc}}
    end
  end

  # H below and to the left of T
  #
  def move({{hr, hc}, {tr, tc}}, {dir, num}) when hr == tr + 1 and hc == tc - 1 and num == 1 do
    case dir do
      :L ->
        {{hr, hc - 1}, {hr, hc}}

      :R ->
        {{hr, hc + 1}, {tr, tc}}

      :U ->
        {{hr - 1, hc}, {tr, tc}}

      :D ->
        {{hr + 1, hc}, {hr, hc}}
    end
  end

  # H below T
  #
  def move({{hr, hc}, {tr, tc}}, {dir, num}) when hr == tr + 1 and tc == hc and num == 1 do
    case dir do
      :L ->
        {{hr, hc - 1}, {tr, tc}}

      :R ->
        {{hr, hc + 1}, {tr, tc}}

      :U ->
        {{hr - 1, hc}, {tr, tc}}

      :D ->
        {{hr + 1, hc}, {tr + 1, tc}}
    end
  end

  # H below and to the right of T
  #
  def move({{hr, hc}, {tr, tc}}, {dir, num}) when hr == tr + 1 and hc == tc + 1 and num == 1 do
    case dir do
      :L ->
        {{hr, hc - 1}, {tr, tc}}

      :R ->
        {{hr, hc + 1}, {hr, hc}}

      :U ->
        {{hr - 1, hc}, {tr, tc}}

      :D ->
        {{hr + 1, hc}, {hr, hc}}
    end
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

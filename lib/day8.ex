defmodule Day8 do
  def part1() do
    parse()
    |> visible_count()
  end

  def visible_count(forest) do
    Map.keys(forest)
    |> Enum.reduce(0, fn coord, acc ->
      if visible?(forest, coord), do: acc + 1, else: acc
    end)
  end

  def visible?(forest, {row, col}, keys \\ nil) do
    height = Map.get(forest, {row, col})

    map_keys = keys || Map.keys(forest)

    left_keys =
      map_keys
      |> Enum.filter(fn {r, c} -> r == row && c < col end)
      |> Enum.sort_by(fn {_, c} -> c end, :desc)

    right_keys =
      map_keys
      |> Enum.filter(fn {r, c} -> r == row && c > col end)
      |> Enum.sort_by(fn {_, c} -> c end, :asc)

    top_keys =
      map_keys
      |> Enum.filter(fn {r, c} -> r < row && c == col end)
      |> Enum.sort_by(fn {r, _} -> r end, :desc)

    bottom_keys =
      map_keys
      |> Enum.filter(fn {r, c} -> r > row && c == col end)
      |> Enum.sort_by(fn {r, _} -> r end, :asc)

    left =
      Enum.all?(left_keys, &(Map.get(forest, &1) < height))

    right =
      Enum.all?(right_keys, &(Map.get(forest, &1) < height))

    top =
      Enum.all?(top_keys, &(Map.get(forest, &1) < height))

    bottom =
      Enum.all?(bottom_keys, &(Map.get(forest, &1) < height))

    left || right || top || bottom
  end

  def parse(input \\ File.read!("lib/fixtures/day8.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, row}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, col}, acc ->
        Map.put(acc, {row, col}, String.to_integer(char))
      end)
    end)
  end
end

defmodule Day8 do
  def part1() do
    parse()
    |> visible_count()
  end

  def part2() do
    parse()
    |> max_visibility_score()
    |> elem(0)
  end

  def visible_count(forest) do
    Map.keys(forest)
    |> Enum.reduce(0, fn coord, acc ->
      if visible?(forest, coord), do: acc + 1, else: acc
    end)
  end

  def visible?(forest, {row, col}) do
    height = Map.get(forest, {row, col})

    map_keys = Map.keys(forest)

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

  def visibility_score(forest, {row, col}) do
    height = Map.get(forest, {row, col})

    map_keys = Map.keys(forest)

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
      Enum.reduce_while(left_keys, 0, fn {r, c}, acc ->
        if Map.get(forest, {r, c}) >= height,
          do: {:halt, acc + 1},
          else: {:cont, acc + 1}
      end)

    right =
      Enum.reduce_while(right_keys, 0, fn {r, c}, acc ->
        if Map.get(forest, {r, c}) >= height,
          do: {:halt, acc + 1},
          else: {:cont, acc + 1}
      end)

    top =
      Enum.reduce_while(top_keys, 0, fn {r, c}, acc ->
        if Map.get(forest, {r, c}) >= height,
          do: {:halt, acc + 1},
          else: {:cont, acc + 1}
      end)

    bottom =
      Enum.reduce_while(bottom_keys, 0, fn {r, c}, acc ->
        if Map.get(forest, {r, c}) >= height,
          do: {:halt, acc + 1},
          else: {:cont, acc + 1}
      end)

    {left * right * top * bottom, {row, col}}
  end

  def max_visibility_score(forest) do
    forest
    |> Map.keys()
    |> Enum.map(fn {row, col} -> visibility_score(forest, {row, col}) end)
    |> Enum.max_by(fn {score, _} -> score end)
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

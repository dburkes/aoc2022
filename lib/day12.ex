defmodule Day12 do
  def part1() do
    {grid, start, target} = parse()
    shortest_path(grid, start, target)
  end

  def part2() do
    {grid, _start, target} = parse()

    # Find all positions with elevation 'a'
    starting_positions = find_all_elevations(grid, ?a)

    # Find the shortest path from any 'a' position
    starting_positions
    |> Enum.map(fn pos -> shortest_path(grid, pos, target) end)
    |> Enum.reject(&is_nil/1)
    |> Enum.min()
  end

  def find_all_elevations(grid, elevation) do
    grid
    |> Enum.filter(fn {_pos, e} -> e == elevation end)
    |> Enum.map(fn {pos, _e} -> pos end)
  end

  def shortest_path(grid, start, target) do
    bfs(grid, [start], target, MapSet.new([start]), %{start => 0})
  end

  def bfs(_grid, [], _target, _visited, _distances), do: nil

  def bfs(grid, [current | rest], target, visited, distances) do
    if current == target do
      Map.get(distances, current)
    else
      current_distance = Map.get(distances, current)
      current_elevation = Map.get(grid, current)

      neighbors = get_neighbors(current)

      {new_queue, new_visited, new_distances} =
        neighbors
        |> Enum.filter(fn pos -> Map.has_key?(grid, pos) end)
        |> Enum.filter(fn pos -> !MapSet.member?(visited, pos) end)
        |> Enum.filter(fn pos -> can_move?(current_elevation, Map.get(grid, pos)) end)
        |> Enum.reduce({rest, visited, distances}, fn pos, {queue, vis, dist} ->
          {
            queue ++ [pos],
            MapSet.put(vis, pos),
            Map.put(dist, pos, current_distance + 1)
          }
        end)

      bfs(grid, new_queue, target, new_visited, new_distances)
    end
  end

  def can_move?(current_elevation, next_elevation) do
    next_elevation <= current_elevation + 1
  end

  def get_neighbors({row, col}) do
    [
      {row - 1, col},
      {row + 1, col},
      {row, col - 1},
      {row, col + 1}
    ]
  end

  def parse(input \\ File.read!("lib/fixtures/day12.txt")) do
    lines =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist/1)

    {grid, start, target} =
      lines
      |> Enum.with_index()
      |> Enum.reduce({%{}, nil, nil}, fn {line, row}, {grid_acc, start_acc, target_acc} ->
        line
        |> Enum.with_index()
        |> Enum.reduce({grid_acc, start_acc, target_acc}, fn {char, col}, {g, s, t} ->
          pos = {row, col}

          cond do
            char == ?S ->
              {Map.put(g, pos, ?a), pos, t}

            char == ?E ->
              {Map.put(g, pos, ?z), s, pos}

            true ->
              {Map.put(g, pos, char), s, t}
          end
        end)
      end)

    {grid, start, target}
  end
end

defmodule Day7 do
  def part1() do
    {fs, _} = Day7.build_from()

    fs
    |> Enum.reduce(0, fn {dirpath, _}, acc ->
      size = dir_size(fs, dirpath)
      if size <= 100_000, do: acc + size, else: acc
    end)
  end

  def part2() do
    {fs, _} = Day7.build_from()

    total_disk_space = 70_000_000
    required_space = 30_000_000
    used_space = dir_size(fs, "/")
    free_space = total_disk_space - used_space
    needed_space = required_space - free_space

    fs
    |> Enum.map(fn {dirpath, _} ->
      {dirpath, dir_size(fs, dirpath)}
    end)
    |> Enum.filter(fn {_, size} -> size >= needed_space end)
    |> Enum.min_by(fn {_, size} -> size end)
    |> elem(1)
  end

  def dir_size(fs, path) do
    fs
    |> Enum.reduce(0, fn {dirpath, files}, acc ->
      # IO.puts("Checking #{dirpath} for inclusion in size of #{path}")

      cond do
        dirpath == path ->
          # IO.puts("Including #{dirpath} in size of #{path}")
          acc + Enum.reduce(files, 0, fn {_, size}, acc -> acc + size end)

        !String.contains?(Path.relative_to(dirpath, path), "/") ->
          # IO.puts("Recursing into #{dirpath} for additions to size of #{path}")
          acc + dir_size(fs, dirpath)

        true ->
          # IO.puts("Excluding #{dirpath} from size of #{path}")
          acc
      end
    end)
  end

  def build_from(input \\ File.read!("lib/fixtures/day7.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[{"/", MapSet.new()}], nil}, &build_fs/2)
  end

  defp build_fs("$ cd /", {fs, _}), do: {fs, "/"}

  defp build_fs("$ cd ..", {fs, path}), do: {fs, Path.dirname(path)}

  defp build_fs("$ cd " <> dir, {fs, path}), do: {fs, Path.join(path, dir)}

  defp build_fs("$ ls", {fs, path}), do: {fs, path}

  defp build_fs("dir " <> dir, {fs, path}) do
    dir_path = Path.join(path, dir)

    case dir_for(fs, dir_path) do
      {path, _} ->
        {fs, path}

      nil ->
        {[{dir_path, MapSet.new()} | fs], path}
    end
  end

  defp build_fs(file_line, {fs, path}) do
    [size, filename] = String.split(file_line, " ")
    {_, files} = dir_for(fs, path)
    new_files = MapSet.put(files, {filename, String.to_integer(size)})
    fs_without_dir = Enum.reject(fs, fn {dir, _} -> dir == path end)
    new_fs = [{path, new_files} | fs_without_dir]
    {new_fs, path}
  end

  defp dir_for(fs, path) do
    List.keyfind(fs, path, 0)
  end
end

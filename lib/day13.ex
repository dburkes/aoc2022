defmodule Day13 do
  def part1() do
    score(parse())
  end

  def score(data) do
    data
    |> Enum.into(%{}, fn {num, pairs} ->
      {num, {pairs, compare(elem(pairs, 0), elem(pairs, 1))}}
    end)
    |> Enum.filter(fn {_, {_, result}} ->
      result == :lt
    end)
    |> Enum.map(fn {num, _} -> num end)
    |> Enum.sort()
    |> Enum.sum()
  end

  def compare(left, right) when is_integer(left) and is_integer(right) do
    cond do
      left < right ->
        :lt

      left == right ->
        :eq

      left > right ->
        :gt
    end
  end

  def compare([], []), do: :eq

  def compare(left, right) when is_list(left) and is_list(right) do
    comparison =
      Enum.zip(left, right)
      |> Enum.reduce_while(:eq, fn {l, r}, _ ->
        case compare(l, r) do
          :lt ->
            {:halt, :lt}

          :gt ->
            {:halt, :gt}

          :eq ->
            {:cont, :eq}
        end
      end)

    case comparison do
      :eq ->
        if length(left) <= length(right), do: :lt, else: :gt

      _ ->
        comparison
    end
  end

  def compare(left, right) when is_integer(left) and is_list(right) do
    compare([left], right)
  end

  def compare(left, right) when is_list(left) and is_integer(right) do
    compare(left, [right])
  end

  def parse(data \\ File.read!("lib/fixtures/day13.txt")) do
    data
    |> String.split("\n\n")
    |> Enum.with_index(1)
    |> Enum.into(%{}, fn {s, n} ->
      [l, r] = String.split(s)
      {n, {elem(Code.eval_string(l), 0), elem(Code.eval_string(r), 0)}}
    end)
  end
end

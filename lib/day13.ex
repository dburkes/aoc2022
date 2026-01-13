defmodule Day13 do
  def part1() do
    score(parse())
  end

  def part2() do
    find_decoder_key(parse())
  end

  def find_decoder_key(data) do
    sorted = sort_packets(data)
    index_2 = Enum.find_index(sorted, &(&1 == [[2]])) + 1
    index_6 = Enum.find_index(sorted, &(&1 == [[6]])) + 1
    index_2 * index_6
  end

  def sort_packets(data) do
      data
      |> Enum.reduce([], fn {_, {l, r}}, acc -> [l, r | acc] end)
      |> Enum.concat([[[2]], [[6]]])
      |> Enum.sort(fn left, right -> compare(left, right) == :lt end)
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
        cond do
          length(left) < length(right) -> :lt
          length(left) > length(right) -> :gt
          true -> :eq
        end

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

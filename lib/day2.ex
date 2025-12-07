defmodule Day2 do
  def part1 do
    parse_rounds()
    |> Enum.map(fn plays -> Day2.score(Enum.at(plays, 0), Enum.at(plays, 1)) end)
    |> Enum.sum()
  end

  def part2 do
    parse_rounds()
    |> Enum.map(fn plays ->
      opponent = Enum.at(plays, 0)
      outcome = Enum.at(plays, 1)
      me = play_for(opponent, outcome)
      Day2.score(opponent, me)
    end)
    |> Enum.sum()
  end

  def parse_rounds(input \\ File.read!("lib/fixtures/day2.txt")) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
  end

  def score(opponent, me) do
    score_outcome(opponent, me) + score_shape(me)
  end

  defp score_outcome(opponent, me) when opponent == "A" do
    case me do
      "X" -> 3
      "Y" -> 6
      "Z" -> 0
    end
  end

  defp score_outcome(opponent, me) when opponent == "B" do
    case me do
      "X" -> 0
      "Y" -> 3
      "Z" -> 6
    end
  end

  defp score_outcome(opponent, me) when opponent == "C" do
    case me do
      "X" -> 6
      "Y" -> 0
      "Z" -> 3
    end
  end

  defp score_shape("X"), do: 1
  defp score_shape("Y"), do: 2
  defp score_shape("Z"), do: 3

  def play_for("A", "X"), do: "Z"
  def play_for("A", "Y"), do: "X"
  def play_for("A", "Z"), do: "Y"
  def play_for("B", "X"), do: "X"
  def play_for("B", "Y"), do: "Y"
  def play_for("B", "Z"), do: "Z"
  def play_for("C", "X"), do: "Y"
  def play_for("C", "Y"), do: "Z"
  def play_for("C", "Z"), do: "X"
end

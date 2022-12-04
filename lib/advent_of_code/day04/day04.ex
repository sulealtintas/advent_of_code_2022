defmodule AdventOfCode.Day04 do
  @spec input :: binary
  def input do
    AdventOfCode.read_input(4)
  end

  @spec solution :: %{puzzle1: number, puzzle2: number}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> to_sets()
    |> Enum.filter(fn [set1, set2] -> one_set_contains_other?(set1, set2) end)
    |> length()
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> to_sets()
    |> Enum.filter(fn [set1, set2] -> sets_overlap?(set1, set2) end)
    |> length()
  end

  defp to_sets(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_ranges/1)
    |> Enum.map(fn [range1, range2] -> [MapSet.new(range1), MapSet.new(range2)] end)
  end

  defp to_ranges(str) do
    [fst, snd] = str |> String.split(",")
    [a, b] = fst |> String.split("-") |> Enum.map(&String.to_integer/1)
    [c, d] = snd |> String.split("-") |> Enum.map(&String.to_integer/1)
    [a..b, c..d]
  end

  defp one_set_contains_other?(set1, set2) do
    MapSet.subset?(set1, set2) || MapSet.subset?(set2, set1)
  end

  defp sets_overlap?(set1, set2) do
    MapSet.intersection(set1, set2) |> MapSet.size() > 0
  end
end

defmodule AdventOfCode.Day03 do
  @spec input :: binary
  def input do
    AdventOfCode.read_input(3)
  end

  @spec solution :: %{puzzle1: number, puzzle2: number}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&to_compartments/1)
    |> Enum.map(&find_common_item/1)
    |> Enum.map(&to_priority/1)
    |> Enum.sum()
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.codepoints/1)
    |> Enum.chunk_every(3)
    |> Enum.map(&find_badge/1)
    |> Enum.map(&to_priority/1)
    |> Enum.sum()
  end

  defp to_compartments(backpack) do
    size = div(length(backpack), 2)
    Enum.chunk_every(backpack, size)
  end

  defp find_common_item([fst, snd]) do
    MapSet.new(fst)
    |> MapSet.intersection(MapSet.new(snd))
    |> Enum.at(0)
  end

  defp find_badge([fst, snd, trd]) do
    MapSet.new(fst)
    |> MapSet.intersection(MapSet.new(snd))
    |> MapSet.intersection(MapSet.new(trd))
    |> Enum.at(0)
  end

  defp to_priority(item) do
    cond do
      item == String.upcase(item) -> :binary.first(item) - 38
      item == String.downcase(item) -> :binary.first(item) - 96
    end
  end
end

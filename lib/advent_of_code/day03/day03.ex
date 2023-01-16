defmodule AdventOfCode.Day03 do
  @spec input :: binary
  def input, do: AdventOfCode.read_input(3)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> parse_backpacks()
    |> Stream.map(&to_compartments/1)
    |> Stream.map(&find_common_item/1)
    |> Stream.map(&to_priority/1)
    |> Enum.sum()
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> parse_backpacks()
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

  defp to_priority(item) when item in ?a..?z, do: item - 96
  defp to_priority(item) when item in ?A..?Z, do: item - 38

  defp parse_backpacks(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_charlist/1)
  end
end

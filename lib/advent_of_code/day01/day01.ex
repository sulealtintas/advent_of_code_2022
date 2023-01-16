defmodule AdventOfCode.Day01 do
  @spec input :: binary
  def input, do: AdventOfCode.read_input(1)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> calories_per_elf_sorted()
    |> Enum.at(0)
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> calories_per_elf_sorted()
    |> Enum.slice(0..2)
    |> Enum.sum()
  end

  defp calories_per_elf_sorted(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn line ->
      line
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
    |> Enum.sort(:desc)
  end
end

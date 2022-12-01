defmodule AdventOfCode.Day01 do
  @spec input :: binary
  def input do
    AdventOfCode.read_input(1)
  end

  @spec solution :: %{puzzle1: number, puzzle2: number}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

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
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn (arr) -> Enum.map(arr, &String.to_integer(&1)) end)
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sort(:desc)
  end
end

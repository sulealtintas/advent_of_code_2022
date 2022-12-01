defmodule AdventOfCode.Day01 do
  def input do
    {:ok, input} = File.read('./lib/advent_of_code/day01/input.txt')
    input
  end

  @spec puzzle1(binary) :: any
  def puzzle1(input) do
    input
    |> calorie_lists_from_input()
    |> calories_per_elf()
    |> Enum.sort(:desc)
    |> Enum.at(0)
  end

  def puzzle2(input) do
    input
    |> calorie_lists_from_input()
    |> calories_per_elf()
    |> Enum.sort(:desc)
    |> Enum.slice(0..2)
    |> Enum.sum()
  end

  def calorie_lists_from_input(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn (arr) -> Enum.map(arr, &String.to_integer(&1)) end)

  end

  def calories_per_elf(calorie_lists) do
    Enum.map(calorie_lists, &Enum.sum(&1))
  end
end

defmodule AdventOfCode.Day01 do
  @spec input :: binary
  def input do
    {:ok, input} = File.read('./lib/advent_of_code/day01/input.txt')
    input
  end

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> calorie_lists_from_input()
    |> calories_per_elf()
    |> Enum.sort(:desc)
    |> Enum.at(0)
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> calorie_lists_from_input()
    |> calories_per_elf()
    |> Enum.sort(:desc)
    |> Enum.slice(0..2)
    |> Enum.sum()
  end

  @spec calorie_lists_from_input(binary) :: list
  def calorie_lists_from_input(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn (arr) -> Enum.map(arr, &String.to_integer(&1)) end)

  end

  @spec calories_per_elf(any) :: list
  def calories_per_elf(calorie_lists) do
    Enum.map(calorie_lists, &Enum.sum(&1))
  end
end

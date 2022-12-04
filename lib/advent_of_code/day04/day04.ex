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
    |> String.split("\n", trim: true)
    |> Enum.map(&to_boundaries/1)
    |> Enum.filter(&one_range_contains_other?/1)
    |> length()
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_boundaries/1)
    |> Enum.filter(&ranges_overlap?/1)
    |> length()
  end

  defp to_boundaries(line) do
    line
    |> String.split([",", "-"])
    |> Enum.map(&String.to_integer/1)
  end

  defp one_range_contains_other?([a, b, c, d]) do
    (a >= c && b <= d) or (a <= c && b >= d)
  end

  defp ranges_overlap?([a, b, c, d]) do
    max(a, c) <= min(b, d)
  end
end

defmodule AdventOfCode.Day04 do
  @spec input :: binary
  def input, do: AdventOfCode.read_input(4)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> parse_boundaries()
    |> Enum.filter(&one_range_contains_other?/1)
    |> length()
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> parse_boundaries()
    |> Enum.filter(&ranges_overlap?/1)
    |> length()
  end

  defp parse_boundaries(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split([",", "-"])
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp one_range_contains_other?([a, b, c, d]) do
    (a >= c && b <= d) or (a <= c && b >= d)
  end

  defp ranges_overlap?([a, b, c, d]) do
    max(a, c) <= min(b, d)
  end
end

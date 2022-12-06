defmodule AdventOfCode.Day06 do
  @spec input :: binary
  def input do
    AdventOfCode.read_input(6)
  end

  @spec solution :: %{puzzle1: pos_integer, puzzle2: pos_integer}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

  @spec puzzle1(binary) :: pos_integer
  def puzzle1(input) do
    input
    |> first_non_repeating(4)
  end

  @spec puzzle2(binary) :: pos_integer
  def puzzle2(input) do
    input
    |> first_non_repeating(14)
  end

  defp first_non_repeating([head | tail], window_size, n) do
    n_distinct =
      [head | tail]
      |> Enum.take(window_size)
      |> Enum.uniq()
      |> length()

    case n_distinct do
      ^window_size -> n
      _ -> first_non_repeating(tail, window_size, n + 1)
    end
  end

  defp first_non_repeating([head | tail], window_size),
    do: first_non_repeating([head | tail], window_size, window_size)

  defp first_non_repeating(str, window_size),
    do: first_non_repeating(String.codepoints(str), window_size)
end

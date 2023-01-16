defmodule AdventOfCode.Day10 do
  @spec input :: binary
  def input, do: AdventOfCode.read_input(10)

  @spec solution :: %{p1: non_neg_integer, p2: binary}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @spec puzzle1(binary) :: non_neg_integer
  def puzzle1(input) do
    input
    |> value_by_cycle()
    |> Stream.drop(19)
    |> Stream.take_every(40)
    |> Stream.map(fn {cycle, value} -> cycle * value end)
    |> Enum.sum()
  end

  @spec puzzle2(binary) :: binary
  def puzzle2(input) do
    input
    |> value_by_cycle()
    |> Stream.chunk_every(40)
    |> Stream.take(6)
    |> Enum.map_join("\n", &draw/1)
  end

  defp value_by_cycle(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map_reduce([{1, 1}], fn cmd, acc ->
      result = operate(cmd, List.last(acc))
      {operate(cmd, List.last(acc)), acc ++ result}
    end)
    |> elem(1)
  end

  defp operate(command, {cycle, value}) do
    case command do
      "noop" ->
        [{cycle + 1, value}]

      "addx " <> v ->
        [{cycle + 1, value}, {cycle + 2, value + String.to_integer(v)}]
    end
  end

  defp draw(row) do
    Enum.map_join(row, fn {cycle, value} ->
      cond do
        rem(cycle - 1, 40) in (value - 1)..(value + 1) -> "#"
        true -> "."
      end
    end)
  end
end

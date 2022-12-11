defmodule AdventOfCode.Day10 do
  @spec input :: binary
  def input do
    AdventOfCode.read_input(10)
  end

  @spec solution :: %{puzzle1: non_neg_integer, puzzle2: binary}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

  @spec puzzle1(binary) :: non_neg_integer
  def puzzle1(input) do
    input
    |> parse()
    |> value_by_cycle()
    |> Enum.map(&interesting_signals/1)
    |> Enum.sum()
  end

  @spec puzzle2(binary) :: binary
  def puzzle2(input) do
    input
    |> parse()
    |> value_by_cycle()
    |> Enum.chunk_every(40)
    |> Enum.map_join("\n", &draw/1)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.map(&String.split(&1, " "))
  end

  defp operate(command, {cycle, value}) do
    case command do
      ["noop"] -> [{cycle + 1, value}]
      [_, v] -> [{cycle + 1, value}, {cycle + 2, value + String.to_integer(v)}]
    end
  end

  defp value_by_cycle(commands, init \\ {1, 1}) do
    Enum.reduce(commands, [init], fn cmd, acc ->
      acc ++ operate(cmd, List.last(acc))
    end)
    |> Enum.reverse()
    |> tl()
    |> Enum.reverse()
  end

  defp interesting_signals({cycle, value}) do
    cond do
      cycle == 20 || rem(cycle + 20, 40) == 0 -> cycle * value
      true -> 0
    end
  end

  defp sprite_position(value) do
    (value - 1)..(value + 1)
  end

  defp draw(row) do
    Enum.map_join(row, fn {cycle, value} ->
      cond do
        rem(cycle - 1, 40) in sprite_position(value) -> "#"
        true -> "."
      end
    end)
  end
end

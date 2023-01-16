defmodule AdventOfCode.Day09 do
  @spec input :: binary
  def input, do: AdventOfCode.read_input(9)

  @spec solution :: %{p1: non_neg_integer, p2: non_neg_integer}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @spec puzzle1(binary) :: non_neg_integer
  def puzzle1(input) do
    input
    |> parse_commands()
    |> trace_tail([{0, 0}])
    |> Enum.uniq()
    |> length
  end

  @spec puzzle2(binary) :: non_neg_integer
  def puzzle2(input) do
    input
    |> parse_commands()
    |> trace_tail(List.duplicate({0, 0}, 9))
    |> Enum.uniq()
    |> length
  end

  defp parse_commands(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
      |> then(fn [direction, n] -> {direction, String.to_integer(n)} end)
      |> then(fn {direction, n} -> List.duplicate(direction, n) end)
    end)
    |> List.flatten()
  end

  defp trace_tail(commands, knots, head \\ {0, 0}, history \\ [{0, 0}]) do
    case commands do
      [] ->
        history

      [direction | rst] ->
        head_new = move_head(head, direction)

        [_ | knots_new] =
          Enum.reduce(knots, [head_new], fn knot, positions ->
            [move_knot(List.first(positions), knot) | positions]
          end)
          |> Enum.reverse()

        trace_tail(rst, knots_new, head_new, [List.last(knots_new) | history])
    end
  end

  defp move_head({x, y}, direction) do
    case direction do
      "U" -> {x, y + 1}
      "R" -> {x + 1, y}
      "D" -> {x, y - 1}
      "L" -> {x - 1, y}
    end
  end

  defp move_knot({x1, y1}, {x2, y2}) do
    cond do
      adjacent?({x1, y1}, {x2, y2}) ->
        {x2, y2}

      true ->
        {x2 + sign(x1 - x2), y2 + sign(y1 - y2)}
    end
  end

  defp adjacent?({x1, y1}, {x2, y2}) do
    not (max(abs(x1 - x2), abs(y1 - y2)) > 1)
  end

  defp sign(n) do
    cond do
      n > 0 -> 1
      n < 0 -> -1
      true -> 0
    end
  end
end

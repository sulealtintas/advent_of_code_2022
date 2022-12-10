defmodule AdventOfCode.Day09 do
  @spec input :: binary
  def input do
    AdventOfCode.read_input(9)
  end

  @spec solution :: %{puzzle1: non_neg_integer, puzzle2: non_neg_integer}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

  @spec puzzle1(binary) :: non_neg_integer
  def puzzle1(input) do
    input
    |> parse_commands()
    |> head_history()
    |> Enum.reduce([{0, 0}], fn head, tails ->
      [move_tail(head, Enum.at(tails, 0)) | tails]
    end)
    |> Enum.uniq()
    |> length
  end

  @spec puzzle2(binary) :: non_neg_integer
  def puzzle2(_input) do
    1
  end

  defp parse_commands(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
      |> (fn [d, s] ->
            %{direction: to_direction(d), steps: String.to_integer(s)}
          end).()
    end)
  end

  defp head_history(commands, head \\ {0, 0}, history \\ [{0, 0}]) do
    case commands do
      [] ->
        history

      [command | rst] ->
        visited = move_head(command, head)
        head_history(rst, List.last(visited), history ++ visited)
    end
  end

  defp move_head(%{direction: {dx, dy}, steps: s}, {x, y}) do
    Enum.map(1..s, fn s -> {x + dx * s, y + dy * s} end)
  end

  defp move_tail({x_head, y_head}, {x_tail, y_tail}) do
    cond do
      adjacent?({x_head, y_head}, {x_tail, y_tail}) ->
        {x_tail, y_tail}

      true ->
        {x_tail + sign(x_head - x_tail), y_tail + sign(y_head - y_tail)}
    end
  end

  defp to_direction(char) do
    case char do
      "U" -> {0, 1}
      "R" -> {1, 0}
      "D" -> {0, -1}
      "L" -> {-1, 0}
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

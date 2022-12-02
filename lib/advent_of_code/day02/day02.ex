defmodule AdventOfCode.Day02 do
  @spec input :: binary
  def input do
    AdventOfCode.read_input(2)
  end

  @spec solution :: %{puzzle1: number, puzzle2: number}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> rounds_from_input()
    |> Enum.map(&score1/1)
    |> Enum.sum()
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> rounds_from_input()
    |> Enum.map(&score2/1)
    |> Enum.sum()
  end

  defp rounds_from_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  defp score1(round) do
    moves = Enum.map(round, &to_move/1)
    [opponent_move, move] = moves

    cond do
      move == losing_move(opponent_move) -> 0 + move
      move == opponent_move -> 3 + move
      move == winning_move(opponent_move) -> 6 + move
    end
  end

  defp score2(round) do
    [move_letter, strategy] = round
    opponent_move = to_move(move_letter)
    case strategy do
      "X" -> 0 + losing_move(opponent_move)
      "Y" -> 3 + opponent_move
      "Z" -> 6 + winning_move(opponent_move)
    end
  end

  defp to_move(letter) do
    case letter do
      "A" -> 1
      "X" -> 1
      "B" -> 2
      "Y" -> 2
      "C" -> 3
      "Z" -> 3
    end
  end

  defp losing_move(opponent_move) do
    rem((opponent_move + 1), 3) + 1
  end

  defp winning_move(opponent_move) do
    rem(opponent_move, 3) + 1
  end
end

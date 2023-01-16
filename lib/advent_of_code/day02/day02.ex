defmodule AdventOfCode.Day02 do
  @spec input :: binary
  def input, do: AdventOfCode.read_input(2)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @move %{
    "A" => :rock,
    "X" => :rock,
    "B" => :paper,
    "Y" => :paper,
    "C" => :scissors,
    "Z" => :scissors
  }

  @wins_over %{rock: :paper, paper: :scissors, scissors: :rock}
  @loses_to %{rock: :scissors, paper: :rock, scissors: :paper}
  @shape_points %{rock: 1, paper: 2, scissors: 3}
  @outcome_points %{lose: 0, draw: 3, win: 6}
  @strategy %{"X" => :lose, "Y" => :draw, "Z" => :win}

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> parse_rounds()
    |> Stream.map(&parse_moves/1)
    |> Stream.map(&score_round/1)
    |> Enum.sum()
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> parse_rounds()
    |> Stream.map(&parse_move_and_strategy/1)
    |> Stream.map(&apply_strategy/1)
    |> Stream.map(&score_round/1)
    |> Enum.sum()
  end

  defp score_round({opponent_move, move}),
    do: @outcome_points[outcome(opponent_move, move)] + @shape_points[move]

  defp outcome(opponent_move, move) do
    cond do
      move == @loses_to[opponent_move] -> :lose
      move == opponent_move -> :draw
      move == @wins_over[opponent_move] -> :win
    end
  end

  defp apply_strategy({move, :draw}), do: {move, move}
  defp apply_strategy({move, :win}), do: {move, @wins_over[move]}
  defp apply_strategy({move, :lose}), do: {move, @loses_to[move]}

  defp parse_moves([letter1, letter2]), do: {@move[letter1], @move[letter2]}
  defp parse_move_and_strategy([letter1, letter2]), do: {@move[letter1], @strategy[letter2]}

  defp parse_rounds(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
  end
end

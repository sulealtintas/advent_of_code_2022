defmodule AdventOfCode.Day10Test do
  use ExUnit.Case
  import AdventOfCode.Day10

  setup_all do
    {:ok, input} = File.read('./test/day10/input.txt')
    cleaned_input = input |> String.replace("\r", "") |> String.trim()
    {:ok, input: cleaned_input}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == 13140
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) ==
             """
             ##..##..##..##..##..##..##..##..##..##..
             ###...###...###...###...###...###...###.
             ####....####....####....####....####....
             #####.....#####.....#####.....#####.....
             ######......######......######......####
             #######.......#######.......#######.....
             """
             |> String.trim()
             |> String.replace("\r", "")
  end
end

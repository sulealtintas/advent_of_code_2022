defmodule AdventOfCode.Day04Test do
  use ExUnit.Case
  import AdventOfCode.Day04

  setup_all do
    input = "
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8" |> String.replace(~r{[\r ]}, "")
    {:ok, input: input}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == 2
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) == 4
  end
end

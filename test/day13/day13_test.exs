defmodule AdventOfCode.Day13Test do
  use ExUnit.Case
  import AdventOfCode.Day13

  setup_all do
    {:ok, input} = File.read('./test/day13/input.txt')
    {:ok, input: String.replace(input, "\r", "")}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == 13
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) == 140
  end
end

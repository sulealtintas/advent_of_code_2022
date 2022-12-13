defmodule AdventOfCode.Day11Test do
  use ExUnit.Case
  import AdventOfCode.Day11

  setup_all do
    {:ok, input} = File.read('./test/day11/input.txt')
    {:ok, input: String.replace(input, "\r", "")}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == 10605
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) == 2_713_310_158
  end
end

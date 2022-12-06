defmodule AdventOfCode.Day05Test do
  use ExUnit.Case
  import AdventOfCode.Day05

  setup_all do
    {:ok, input} = File.read('./test/day05/input.txt')
    {:ok, input: String.replace(input, "\r", "")}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == "CMZ"
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) == "MCD"
  end
end

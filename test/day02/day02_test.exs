defmodule AdventOfCode.Day02Test do
  use ExUnit.Case
  import AdventOfCode.Day02

  setup_all do
    input = "A Y\nB X\nC Z\n"
    {:ok, input: input}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == 15
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) == 12
  end
end

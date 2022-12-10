defmodule AdventOfCode.Day09Test do
  use ExUnit.Case
  import AdventOfCode.Day09

  setup_all do
    input = "R 4\nU 4\nL 3\nD 1\nR 4\nD 1\nL 5\nR 2"

    {:ok, input: input}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == 13
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) == 36
  end
end

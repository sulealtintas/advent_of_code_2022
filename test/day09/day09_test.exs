defmodule AdventOfCode.Day09Test do
  use ExUnit.Case
  import AdventOfCode.Day09

  setup_all do
    input1 = "R 4\nU 4\nL 3\nD 1\nR 4\nD 1\nL 5\nR 2"
    input2 = "R 5\nU 8\nL 8\nD 3\nR 17\nD 10\nL 25\nU 20"

    {:ok, input1: input1, input2: input2}
  end

  test "puzzle 1", %{input1: input} do
    assert puzzle1(input) == 13
  end

  test "puzzle 2", %{input2: input} do
    assert puzzle2(input) == 36
  end
end

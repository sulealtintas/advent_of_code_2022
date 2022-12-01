defmodule AdventOfCode.Day01Test do
  use ExUnit.Case
  import AdventOfCode.Day01

  setup_all do
    input = "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000\n"
    {:ok, input: input}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == 24000
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) == 45000
  end
end

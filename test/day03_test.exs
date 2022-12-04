defmodule AdventOfCode.Day03Test do
  use ExUnit.Case
  import AdventOfCode.Day03

  setup_all do
    input = "
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw" |> String.replace(~r{[\r ]}, "")
    {:ok, input: input}
  end

  test "puzzle 1", %{input: input} do
    assert puzzle1(input) == 157
  end

  test "puzzle 2", %{input: input} do
    assert puzzle2(input) == 70
  end
end

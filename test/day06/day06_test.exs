defmodule AdventOfCode.Day06Test do
  use ExUnit.Case
  import AdventOfCode.Day06

  test "puzzle 1" do
    assert puzzle1("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
    assert puzzle1("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert puzzle1("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert puzzle1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert puzzle1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end

  test "puzzle 2" do
    assert puzzle2("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
    assert puzzle2("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
    assert puzzle2("nppdvjthqldpwncqszvftbrmjlhg") == 23
    assert puzzle2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
    assert puzzle2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
  end
end

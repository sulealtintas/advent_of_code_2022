defmodule Monkey do
  defstruct items: [],
            operation: &Function.identity/1,
            divisor: nil,
            pass_true: nil,
            pass_false: nil,
            inspected: 0
end

defmodule AdventOfCode.Day11 do
  import Monkey

  @spec input :: binary
  def input do
    AdventOfCode.read_input(11)
  end

  @spec solution :: %{puzzle1: number, puzzle2: number}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> parse_monkeys()
    |> monkey_business(20, 3)
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> parse_monkeys()
    |> monkey_business(10000)
  end

  defp monkey_business(monkeys, rounds, worry_divisor \\ 1) do
    monkeys
    |> play_rounds(rounds, common_multiple(monkeys), worry_divisor)
    |> Enum.map(fn {_id, monkey} -> monkey.inspected end)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  defp play_rounds(monkeys, n, multiple, worry_divisor) do
    Enum.reduce(1..n, monkeys, fn _i, acc ->
      Enum.reduce(0..(Enum.count(acc) - 1), acc, fn id, round ->
        take_turn(round, id, multiple, worry_divisor)
      end)
    end)
  end

  defp take_turn(monkeys, id, multiple, worry_divisor) do
    monkey = monkeys[id]
    monkey_true = monkeys[monkey.pass_true]
    monkey_false = monkeys[monkey.pass_false]

    {items_true, items_false} =
      monkey.items
      |> Enum.map(fn item ->
        item
        |> then(monkey.operation)
        |> div(worry_divisor)
        |> rem(multiple)
      end)
      |> Enum.split_with(fn item -> rem(item, monkey.divisor) == 0 end)

    %{
      monkeys
      | id => %Monkey{
          monkey
          | items: [],
            inspected: monkey.inspected + length(monkey.items)
        },
        monkey.pass_true => %Monkey{
          monkey_true
          | items: monkey_true.items ++ items_true
        },
        monkey.pass_false => %Monkey{
          monkey_false
          | items: monkey_false.items ++ items_false
        }
    }
  end

  defp common_multiple(monkeys) do
    monkeys
    |> Enum.map(fn {_id, monkey} -> monkey.divisor end)
    |> Enum.product()
  end

  defp parse_monkeys(input) do
    input
    |> String.split("\n\n")
    |> Enum.reduce(%{}, fn line, monkeys ->
      [
        "Monkey " <> id,
        "  Starting items: " <> items,
        "  Operation: new = " <> operation,
        "  Test: divisible by " <> divisor,
        "    If true: throw to monkey " <> pass_true,
        "    If false: throw to monkey " <> pass_false
      ] = String.split(line, "\n", trim: true)

      monkey = %Monkey{
        items: parse_items(items),
        operation: parse_operation(operation),
        divisor: parse_number(divisor),
        pass_true: parse_number(pass_true),
        pass_false: parse_number(pass_false)
      }

      Map.put(monkeys, parse_id(id), monkey)
    end)
  end

  defp parse_items(str) do
    str
    |> String.split(", ")
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_operation(str) do
    case str do
      "old * old" -> fn old -> old * old end
      "old * " <> n -> fn old -> old * String.to_integer(n) end
      "old + " <> n -> fn old -> old + String.to_integer(n) end
    end
  end

  defp parse_number(str), do: String.trim(str) |> String.to_integer()
  defp parse_id(str), do: parse_number(String.replace(str, ":", ""))
end

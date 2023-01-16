defmodule Packets do
  @spec compare(any, any) :: :eq | :gt | :lt
  def compare(a, a), do: :eq
  def compare(a, b) when is_integer(a) and is_integer(b) and a < b, do: :lt
  def compare(a, b) when is_integer(a) and is_integer(b) and a > b, do: :gt
  def compare(a, b) when is_integer(a) and is_list(b), do: compare([a], b)
  def compare(a, b) when is_list(a) and is_integer(b), do: compare(a, [b])
  def compare([], [_ | _]), do: :lt
  def compare([_ | _], []), do: :gt

  def compare([a | as], [b | bs]) do
    comparison = compare(a, b)

    case comparison do
      :eq -> compare(as, bs)
      val -> val
    end
  end
end

defmodule AdventOfCode.Day13 do
  @spec input :: binary
  def input, do: AdventOfCode.read_input(13)

  @spec solution :: %{p1: number, p2: number}
  def solution, do: %{p1: puzzle1(input()), p2: puzzle2(input())}

  @spec puzzle1(binary) :: number
  def puzzle1(input) do
    input
    |> parse_packets()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [a, b] -> Packets.compare(a, b) != :gt end)
    |> Enum.with_index(1)
    |> Enum.filter(fn {sorted, _i} -> sorted end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  @spec puzzle2(binary) :: number
  def puzzle2(input) do
    input
    |> parse_packets()
    |> List.insert_at(0, [[2]])
    |> List.insert_at(0, [[6]])
    |> Enum.sort(Packets)
    |> Enum.with_index(1)
    |> Enum.filter(fn {val, _i} -> val in [[[2]], [[6]]] end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.product()
  end

  defp parse_packets(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn str -> elem(Code.eval_string(str), 0) end)
  end
end

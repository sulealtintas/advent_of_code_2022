defmodule AdventOfCode.Day05 do
  @spec input :: binary
  def input do
    AdventOfCode.read_input(5)
  end

  @spec solution :: %{puzzle1: binary, puzzle2: binary}
  def solution do
    %{puzzle1: puzzle1(input()), puzzle2: puzzle2(input())}
  end

  @spec puzzle1(binary) :: binary
  def puzzle1(input) do
    {crates, commands} = parse(input)

    Enum.reduce(commands, crates, fn command, acc ->
      crate_mover_9000(acc, command)
    end)
    |> Enum.map(&Enum.at(&1, 0))
    |> Enum.join()
  end

  @spec puzzle2(binary) :: binary
  def puzzle2(input) do
    {crates, commands} = parse(input)

    Enum.reduce(commands, crates, fn command, acc ->
      crate_mover_9001(acc, command)
    end)
    |> Enum.map(&Enum.at(&1, 0))
    |> Enum.join()
  end

  defp crate_mover_9000(crates, 1, from, to) do
    [head | stack_removed_from] = Enum.at(crates, from)
    stack_pushed_to = [head | Enum.at(crates, to)]

    crates
    |> List.replace_at(from, stack_removed_from)
    |> List.replace_at(to, stack_pushed_to)
  end

  defp crate_mover_9000(crates, count, from, to) do
    Enum.reduce(1..count, crates, fn _i, acc ->
      crate_mover_9000(acc, 1, from, to)
    end)
  end

  defp crate_mover_9000(crates, command) do
    crate_mover_9000(crates, command[:move], command[:from] - 1, command[:to] - 1)
  end

  defp crate_mover_9001(crates, count, from, to) do
    {moved_crates, stack_removed_from} = Enum.at(crates, from) |> Enum.split(count)
    stack_pushed_to = moved_crates ++ Enum.at(crates, to)

    crates
    |> List.replace_at(from, stack_removed_from)
    |> List.replace_at(to, stack_pushed_to)
  end

  defp crate_mover_9001(crates, command) do
    crate_mover_9001(crates, command[:move], command[:from] - 1, command[:to] - 1)
  end

  defp parse(input) do
    [diagram, text] = String.split(input, "\n\n")
    {parse_crates(diagram), parse_commands(text)}
  end

  defp parse_commands(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.chunk_every(2)
      |> Enum.map(fn [k, v] -> {String.to_atom(k), String.to_integer(v)} end)
      |> Enum.into(%{})
    end)
  end

  defp parse_crates(diagram) do
    diagram
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.codepoints()
      |> Enum.chunk_every(4)
      |> Enum.map(&Enum.at(&1, 1))
    end)
    |> Enum.reverse()
    |> Enum.drop(1)
    |> Enum.zip_with(& &1)
    |> Enum.map(&Enum.filter(&1, fn crate -> crate != " " end))
    |> Enum.map(&Enum.reverse/1)
  end
end

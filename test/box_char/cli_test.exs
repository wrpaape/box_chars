defmodule BoxChar.CLITest do
  use ExUnit.Case
  doctest BoxChar.CLI

  alias IO.ANSI
  alias BoxChar.CLI
  alias BoxChar.CLIError
  alias BoxChar.ArgVError

  import ExUnit.CaptureIO

  @usage  Application.get_env(:box_char, :usage)
  @errors Application.get_env(:box_char, :errors)
  @help_flags    ~w(--help -h)
  @mode_flags    [map: ~w(--map -m), swap: ~w(--swap -s)]
  @charset_flags [light: ~w(light l), heavy: ~w(heavy h), double: ~W(double d), all: ~w(all a)]

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "help flag in argv => prints usage" do
    assert capture_io(fn ->
      @help_flags
      |> Enum.random
      |> shuffle_in(rand_modes)
      |> shuffle_with(rand_charset_str)
      |> CLI.main
    end) |> trim == @usage
  end

  def rand_modes do
   @mode_flags 
   |> rand_chunk_vals
   |> Enum.map(&Enum.random/1)
  end

  def rand_charset_str do
    @charset_flags
    |> rand_chunk_vals
    |> Enum.map_join("/", &Enum.random/1) 
  end

  def take_rand_flags(flags, count) do
    flags
    |> Keyword.keys
    |> List.flatten
    |> Enum.take_random(count)
  end

  def shuffle_in(term, list),   do: Enum.shuffle([term | list])
  def shuffle_with(list, term), do: Enum.shuffle([term | list])
  def shuffle_into(l1, l2),     do: Enum.shuffle(l1 ++ l2)

  def rand_chunk(list), do: Enum.take_random(list, rand_count(list))
  def rand_count(list), do: :rand.uniform(length(list) + 1) - 1
  def rand_chunk_vals(flags) do
    flags
    |> rand_chunk
    |> Keyword.values
  end

  defp trim(str), do: :binary.replace(str, ansi_pattern, "", [:global]) 

  # defp pattern, do: :binary.compile_pattern([puts_status | ansi_pattern])

  # defp puts_status, do: capture_io(fn -> IO.puts "" end) 

  defp ansi_pattern do
    ANSI.__info__(:functions)
    |> Enum.filter_map(&(elem(&1, 1) == 0), &apply(ANSI, elem(&1, 0), []))
    |> Enum.filter(&is_binary/1)
    |> :binary.compile_pattern
  end
end
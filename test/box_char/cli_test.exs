defmodule BoxChar.CLITest do
  use ExUnit.Case
  doctest BoxChar.CLI

  @mode_flags    [map: ~w(--map -m), swap: ~w(--swap -s)]
  @charset_flags [light: ~w(light l), heavy: ~w(heavy h), double: ~W(double d), all: ~w(all a)]

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "help flag in argv => prints usage" do
    ~w(--help -h)
    |> Enum.
  end

  def rand_valid_argv do
    

  end

  def rand_in(keyword) do


  end
end

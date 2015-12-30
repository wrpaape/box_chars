defmodule BoxChar.CLI do
  alias IO.ANSI
 # File.stream!(path, [:read, :char_list, encoding: :unicode], :line)   
  @def_path Application.get_env(:box_char, :def_path)
  @def_opts Application.get_env(:box_char, :def_opts)

  @parse_opts [switches: [help: :boolean, map: :string, swap: :string],
               aliases:  [h:    :help,    m:   :map,    s:    :swap]]

  # @type_parse_opts [switches: [map: :boolean, swap: :boolean, light: :boolean, heavy: :boolean, double: :boolean, all: :boolean],
  #                   aliases:  [m:   :map,     s:    :swap,    l:     :light,   h:     :heavy,   d:      :double,  a:   :all]]

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  #external API ^

  def parse_args(argv) do
    argv
    |> OptionParser.parse(@parse_opts)
    |> case do
      {[help: true], ____, ___} ->
        |> print_help_and_halt

      {[], _________, ________} ->
        "please specify <mode> of operation"
        |> handle_error
       
      {[mode_tup], rem_argv, _} ->
        rem_argv
        |> parse_path
        |> extract_files
        |> parse_type(mode_tup) 

        _______________________ -> 
        "too many args!"
        |> handle_error
    end
  end

  def parse_path([path]), do: path
  def parse_path([]),     do: handle_error("please specify <path> to file or populated directory")
  def parse_path(_),      do: handle_error("too many args!") 

  def extract_files(path) do
    path
    |> Path.wildcard
    |> Enum.filter(&File.regular?/1)
  end

  def parse_next([last_arg], [], opts_tup), do: opts_tup

  def parse_next([], [], opts_tup), do: opts_tup

  def process(:help) do
    """
    usage:

      box_char <path> map <type>

    or

      box_char <path> swap <old_type> <new_type>
    """
    |> alert(:blue)

    System.halt(0)
  end

  def process({:error, opt, argv}) do
    """
    failed to parse <#{opt}> from:

      #{argv}
    """
    |> alert(:red)

    process(:help)
  end

  def process({[:swap, old_type, new_type], files})

  #helpers v  


  defmacrop alert(msg, color) do
    quote do
      apply(ANSI, unquote(color), [])
      <> unquote(msg)
      <> ANSI.reset
      |> IO.puts
    end
  end
end

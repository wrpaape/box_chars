defmodule BoxChar do
  alias BoxChar.Mapper
  alias BoxChar.Swapper

  def process({:help, msg}),             do: IO.write(msg)
  def process({:swap, charsets, files}), do: spawn_workers(charsets, files, Swapper)
  def process({:map, escapes, files})    do
    escapes
    |> Enum.map(:binary.compile_pattern/1)
    |> List.insert_at(-1, hd(escapes))
    |> spawn_workers(files, Mapper)
  end

  def spawn_workers(args, files, mod), do: Enum.each(files, &spawn(mod, :scan, [&1 | args]))

  def write_to_file(contents, file), do: File.write!(file, contents)
end

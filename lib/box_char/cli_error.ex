defmodule BoxChar.CLIError do
  
  error {:invalid_path, path}, do: "invalid path:\n  " <> path
  error({:no_files_found, path}), do: put_msg("failed to find file(s) at path:\n  " <> path)
  error({:invalid_args, args})    do
    [{"invalid args:"} | args]
    |> Enum.map_join("\n  ", &elem(&1, 0))
    |> put_message
  end
  error(:missing_swap_charset),    do: put_msg("please specify <new charset> to swap to")
  error(:extra_swap_charsets),     do: put_msg("may only swap one <charset> at a time")


  defp put_msg(msg), do: %__MODULE__{message: msg}
end
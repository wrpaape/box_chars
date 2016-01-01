defmodule BoxChar do
  @box_char %{
    thick:  %{
      lines: %{
        horiz: "═",
        vert:  "║"
      },
      joiners: %{
        top: "╦",
        mid: "╬",
        bot: "╩"
      },
      caps: %{
        top: %{left: "╔", right: "╗"},
        mid: %{left: "╠", right: "╣"},
        bot: %{left: "╚", right: "╝"}
      }
    },
    thin: %{
      lines: %{
        horiz: "─",
        vert:  "│"
      },
      joiners: %{
        top: "┬",
        mid: "┼",
        bot: "┴"
      },
      caps: %{
        top: %{left: "┌", right: "┐"},
        mid: %{left: "├", right: "┤"},
        bot: %{left: "└", right: "┘"}
      }
    }
  }

  def process({:swap, old_charset, new_charset, files}) do
  end

  def process({:map, charsets, files}) do
  end
end

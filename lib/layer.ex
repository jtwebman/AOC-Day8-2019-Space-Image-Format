defmodule Day8.Layer do
  defstruct [:width, :height, :rows]

  def new(width, height, value) do
    %__MODULE__{
      width: width,
      height: height,
      rows:
        value
        |> Stream.unfold(&String.split_at(&1, width))
        |> Enum.take_while(&(&1 != ""))
        |> Enum.map(&String.split(&1, "", trim: true))
    }
  end

  def render(%__MODULE__{rows: rows}) do
    Enum.reduce(rows, "", fn row, acc ->
      acc <> List.to_string(List.flatten(Enum.map(row, &render_char/1))) <> "\n"
    end)
  end

  def render_char(val) do
    case val do
      "1" -> [IO.ANSI.white(), 9608]
      _ -> " "
    end
  end

  def merge(
        %__MODULE__{rows: rows_b},
        %__MODULE__{rows: rows_a, width: width, height: height}
      ) do
    new(width, height, merge_items(List.flatten(rows_a), List.flatten(rows_b), ""))
  end

  def merge_items([], [], new_value) do
    new_value
  end

  def merge_items([next_a | rest_a], [next_b | rest_b], new_value) do
    merge_items(rest_a, rest_b, new_value <> merge_value(next_a, next_b))
  end

  def merge_value(val_a, val_b) do
    case val_a do
      "2" -> val_b
      _ -> val_a
    end
  end

  def count(%__MODULE__{rows: rows}, looking_for) do
    Enum.count(List.flatten(rows), &(&1 == looking_for))
  end
end

defmodule Day8 do
  alias Day8.{Image, Input, Layer}

  def run() do
    IO.puts(
      Image.new(25, 6, Input.input())
      |> Image.render()
      |> String.replace("1", "*")
      |> String.replace("0", " ")
    )
  end

  def run_part1() do
    layer =
      Image.new(25, 6, Input.input())
      |> Image.min_layer_with("0")

    Layer.count(layer, "1") * Layer.count(layer, "2")
  end
end

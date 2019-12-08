defmodule Day8.Image do
  alias Day8.Layer
  defstruct [:width, :height, :layers]

  def new(width, height, value) do
    per_layer = width * height

    layers =
      value
      |> Stream.unfold(&String.split_at(&1, per_layer))
      |> Enum.take_while(&(&1 != ""))
      |> Enum.map(&Layer.new(width, height, &1))

    %__MODULE__{width: width, height: height, layers: layers}
  end

  def render(%__MODULE__{layers: layers}) do
    Enum.reduce(layers, &Layer.merge/2)
    |> Layer.render()
  end

  def min_layer_with(%__MODULE__{layers: layers}, value) do
    layers
    |> Enum.min_by(&Layer.count(&1, value))
  end
end

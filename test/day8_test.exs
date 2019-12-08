defmodule Day8Test do
  use ExUnit.Case

  alias Day8.Image

  test "part2 test 1" do
    assert Image.new(2, 2, "0222112222120000")
           |> Image.render() == "01\n10\n"
  end
end

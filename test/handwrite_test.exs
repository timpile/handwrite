defmodule HandwriteTest do
  use ExUnit.Case
  doctest Handwrite

  test "greets the world" do
    assert Handwrite.hello() == :world
  end
end

defmodule FumetsuTest do
  use ExUnit.Case
  doctest Fumetsu

  test "greets the world" do
    assert Fumetsu.hello() == :world
  end
end

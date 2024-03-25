defmodule MatchesTest do
  use ExUnit.Case
  doctest Matches

  test "greets the world" do
    assert Matches.hello() == :world
  end
end

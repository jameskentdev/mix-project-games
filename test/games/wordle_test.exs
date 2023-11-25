defmodule WordleTest do
  use ExUnit.Case

  test "all green" do
    assert Games.Wordle.feedback("aaa", "aaa") == [:green, :green, :green]
  end

  test "all yellow" do
    assert Games.Wordle.feedback("abcd", "dcba") == [:yellow, :yellow, :yellow, :yellow]
  end

  test "all grey" do
    assert Games.Wordle.feedback("abc", "efg") == [:grey, :grey, :grey]
  end

  test "some green, yellow, and grey" do
    assert Games.Wordle.feedback("abcd", "aedf") == [:green, :grey, :yellow, :grey]
  end
end

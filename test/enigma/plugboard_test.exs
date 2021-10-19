defmodule Enigma.PlugboardTest do
  use ExUnit.Case

  alias Enigma.Plugboard

  describe "Enigma.Plugboard.new/2" do
    test "defaults to a straight-through mapping" do
      plugboard = Plugboard.new([])
      # no need to test all 26 mappings!
      assert %{0 => 0, 10 => 10, 25 => 25} = plugboard.mapping
    end

    test "overrides the mapping for each pair of patched letters" do
      plugboard = Plugboard.new([{"A", "F"}, {"X", "C"}])
      assert %{0 => 5, 5 => 0, 23 => 2, 2 => 23, 1 => 1} = plugboard.mapping
    end
  end
end

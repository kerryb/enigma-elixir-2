defmodule Enigma.ReflectorTest do
  use ExUnit.Case

  alias Enigma.Reflector

  describe "Enigma.Reflector.new/2" do
    test "initialises the mapping" do
      reflector = Reflector.new("EJMZALYXVBWFCRQUONTSPIKHGD")
      # no need to test all 26 mappings!
      assert %{"A" => "E", "M" => "C", "Z" => "D"} = reflector.mapping
    end
  end
end

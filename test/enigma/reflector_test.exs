defmodule Enigma.ReflectorTest do
  use ExUnit.Case

  alias Enigma.Reflector

  describe "Enigma.Reflector.new/2" do
    test "initialises the mapping" do
      rotor = Reflector.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ")
      # no need to test all 26 mappings!
      assert %{"A" => "E", "M" => "O", "Z" => "J"} = rotor.mapping
    end
  end
end

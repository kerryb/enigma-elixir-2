defmodule Enigma.RotorTest do
  use ExUnit.Case

  alias Enigma.Rotor

  describe "Enigma.Rotor.new/2" do
    test "initialises the forward mapping" do
      rotor = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
      # no need to test all 26 mappings!
      assert %{"A" => "E", "M" => "O", "Z" => "J"} = rotor.forward_mapping
    end

    test "initialises the reverse mapping" do
      rotor = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
      assert %{"E" => "A", "O" => "M", "J" => "Z"} = rotor.reverse_mapping
    end

    test "stores the notch position" do
      rotor = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
      assert rotor.notch == "Q"
    end
  end

  describe "Enigma.Rotor.with_ring_position/2" do
    test "returns a rotor with modified forward mapping" do
      rotor = "EKMFLGDQVZNTOWYHXUSPAIBRCJ" |> Rotor.new("Q") |> Rotor.with_ring_position(3)
      assert %{"D" => "H", "P" => "R", "C" => "M"} = rotor.forward_mapping
    end

    test "returns a rotor with modified reverse mapping" do
      rotor = "EKMFLGDQVZNTOWYHXUSPAIBRCJ" |> Rotor.new("Q") |> Rotor.with_ring_position(3)
      assert %{"H" => "D", "R" => "P", "M" => "C"} = rotor.reverse_mapping
    end

    test "returns a rotor with modified notch position" do
      rotor = "EKMFLGDQVZNTOWYHXUSPAIBRCJ" |> Rotor.new("Q") |> Rotor.with_ring_position(3)
      assert rotor.notch == "T"
    end
  end
end

defmodule Enigma.InstallerRotorTest do
  use ExUnit.Case

  alias Enigma.{InstalledRotor, Rotor}

  describe "Enigma.InstalledRotor.new/2" do
    test "sets the mapping when the rotor is installed in home (A) position" do
      rotor = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
      installed_rotor = InstalledRotor.new(rotor, "A")
      assert %{0 => 4, 25 => 9} = installed_rotor.forward_mapping
    end

    test "sets the mapping when the rotor is installed in a different position" do
      rotor = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
      installed_rotor = InstalledRotor.new(rotor, "K")
      assert %{16 => 20, 15 => 25} = installed_rotor.forward_mapping
    end

    test "sets the reverse mapping" do
      rotor = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
      installed_rotor = InstalledRotor.new(rotor, "K")
      assert %{20 => 16, 25 => 15} = installed_rotor.reverse_mapping
    end

    test "stores the rotor's notch position" do
      rotor = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
      assert InstalledRotor.new(rotor, "K").notch == "Q"
    end

    test "sets the position" do
      rotor = Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
      assert InstalledRotor.new(rotor, "K").position == "K"
    end
  end
end

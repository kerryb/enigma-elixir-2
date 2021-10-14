defmodule Enigma.InstallerReflectorTest do
  use ExUnit.Case

  alias Enigma.{InstalledReflector, Reflector}

  describe "Enigma.InstalledReflector.new/2" do
    test "sets the mapping" do
      reflector = Reflector.new("EJMZALYXVBWFCRQUONTSPIKHGD")
      installed_reflector = InstalledReflector.new(reflector)

      assert %{0 => 4, 25 => 3} = installed_reflector.mapping
    end
  end

  describe "Enigma.InstalledReflector.map/2" do
    test "returns the mapped pin" do
      reflector = Reflector.new("EJMZALYXVBWFCRQUONTSPIKHGD")
      installed_reflector = InstalledReflector.new(reflector)
      assert InstalledReflector.map(installed_reflector, 0) == 4
    end
  end
end

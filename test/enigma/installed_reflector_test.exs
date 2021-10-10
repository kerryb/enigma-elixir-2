defmodule Enigma.InstallerReflectorTest do
  use ExUnit.Case

  alias Enigma.{InstalledReflector, Reflector}

  describe "Enigma.InstalledReflector.new/2" do
    test "sets identical forward and reverse mappings" do
      reflector = Reflector.new("EJMZALYXVBWFCRQUONTSPIKHGD")
      installed_reflector = InstalledReflector.new(reflector)

      assert %{forward_mapping: %{0 => 4, 25 => 3} = mapping, reverse_mapping: mapping} =
               installed_reflector
    end
  end
end

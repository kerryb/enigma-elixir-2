defmodule Enigma.MachineTest do
  use ExUnit.Case

  alias Enigma.Machine

  describe "Enigma.Machine" do
    test "encrypts with everything starting in default positions" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_i(), "A"}, {Enigma.rotor_ii(), "A"}, {Enigma.rotor_iii(), "A"}],
          Enigma.reflector_b()
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "MFNCZBBFZM"
    end

    test "encrypts with rotors in a different order" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_ii(), "A"}, {Enigma.rotor_iii(), "A"}, {Enigma.rotor_i(), "A"}],
          Enigma.reflector_b()
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "ZXVMIZYFEY"
    end
  end
end

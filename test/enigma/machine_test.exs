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

    test "encrypts with different initial positions" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_i(), "B"}, {Enigma.rotor_ii(), "X"}, {Enigma.rotor_iii(), "J"}],
          Enigma.reflector_b()
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "QNDMFRCGTS"
    end

    test "turns over the rotors correctly" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_i(), "Q"}, {Enigma.rotor_ii(), "E"}, {Enigma.rotor_iii(), "A"}],
          Enigma.reflector_b()
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "NIJMQPUDGW"
    end

    test "double-steps the second rotor as expected" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_i(), "P"}, {Enigma.rotor_ii(), "D"}, {Enigma.rotor_iii(), "A"}],
          Enigma.reflector_b()
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "XUWJPJIBIE"
    end
  end
end

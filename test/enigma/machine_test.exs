defmodule Enigma.MachineTest do
  use ExUnit.Case

  alias Enigma.{Machine, Rotor, Plugboard}

  describe "Enigma.Machine" do
    test "encrypts with everything starting in default positions" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_i(), "A"}, {Enigma.rotor_ii(), "A"}, {Enigma.rotor_iii(), "A"}],
          Enigma.reflector_b(),
          Plugboard.new([])
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "MFNCZBBFZM"
    end

    test "encrypts with rotors in a different order" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_ii(), "A"}, {Enigma.rotor_iii(), "A"}, {Enigma.rotor_i(), "A"}],
          Enigma.reflector_b(),
          Plugboard.new([])
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "ZXVMIZYFEY"
    end

    test "encrypts with different initial positions" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_i(), "B"}, {Enigma.rotor_ii(), "X"}, {Enigma.rotor_iii(), "J"}],
          Enigma.reflector_b(),
          Plugboard.new([])
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "QNDMFRCGTS"
    end

    test "turns over the rotors correctly" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_i(), "Q"}, {Enigma.rotor_ii(), "E"}, {Enigma.rotor_iii(), "A"}],
          Enigma.reflector_b(),
          Plugboard.new([])
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "NIJMQPUDGW"
    end

    test "double-steps the second rotor as expected" do
      {:ok, machine} =
        Machine.start_link([
          [{Enigma.rotor_i(), "P"}, {Enigma.rotor_ii(), "D"}, {Enigma.rotor_iii(), "A"}],
          Enigma.reflector_b(),
          Plugboard.new([])
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "XUWJPJIBIE"
    end

    test "encrypts with the alphabet rings in non-default positions" do
      {:ok, machine} =
        Machine.start_link([
          [
            {Enigma.rotor_i() |> Rotor.with_ring_position(4), "A"},
            {Enigma.rotor_ii() |> Rotor.with_ring_position(12), "A"},
            {Enigma.rotor_iii() |> Rotor.with_ring_position(19), "A"}
          ],
          Enigma.reflector_b(),
          Plugboard.new([])
        ])

      assert Machine.encrypt(machine, "HELLOWORLD") == "JCEESPSDYR"
    end
  end
end

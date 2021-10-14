defmodule Enigma.Machine do
  use GenServer

  alias Enigma.{InstalledReflector, InstalledRotor}

  @enforce_keys [:rotors, :reflector]
  defstruct [:rotors, :reflector]

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init([rotors, reflector]) do
    {:ok,
     %__MODULE__{
       rotors: Enum.map(rotors, &install_rotor/1),
       reflector: InstalledReflector.new(reflector)
     }}
  end

  defp install_rotor({rotor, position}), do: InstalledRotor.new(rotor, position)

  def encrypt(machine, text) do
    text
    |> String.codepoints()
    |> Enum.map(&GenServer.call(machine, {:encrypt, &1}))
    |> Enum.join()
  end

  @impl true
  def handle_call({:encrypt, <<letter>>}, _from, state) do
    state = advance(state)
    {:reply, encrypt_letter(state, letter), state}
  end

  defp advance(state) do
    Map.update!(state, :rotors, fn rotors ->
      [nil | rotors]
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(&maybe_advance/1)
    end)
  end

  defp maybe_advance([previous_rotor, rotor]) do
    if is_nil(previous_rotor) or InstalledRotor.notch_lined_up?(previous_rotor) do
      IO.puts("Advancing rotor with notch at #{inspect(rotor.notch)}")
      InstalledRotor.advance(rotor)
    else
      rotor
    end
  end

  defp encrypt_letter(state, letter) do
    pin =
      (letter - ?A)
      |> IO.inspect(label: "pin")
      |> forward_through_rotors(state.rotors)
      |> IO.inspect(label: "forward")
      |> through_reflector(state.reflector)
      |> IO.inspect(label: "reflected")
      |> backward_through_rotors(state.rotors)
      |> IO.inspect(label: "backward")

    <<pin + ?A>>
  end

  defp forward_through_rotors(pin, rotors) do
    Enum.reduce(rotors, pin, &InstalledRotor.map_forward/2)
  end

  defp through_reflector(pin, reflector) do
    InstalledReflector.map(reflector, pin)
  end

  defp backward_through_rotors(pin, rotors) do
    rotors
    |> Enum.reverse()
    |> Enum.reduce(pin, &InstalledRotor.map_back/2)
  end
end

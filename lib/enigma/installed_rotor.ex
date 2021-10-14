defmodule Enigma.InstalledRotor do
  @moduledoc """
  A struct representing an installed rotor, taking account of its rotary
  position.
  """

  @enforce_keys [:forward_mapping, :reverse_mapping, :notch, :position]
  defstruct [:forward_mapping, :reverse_mapping, :notch, :position]

  @doc """
  Given a rotor and a starting position, return a struct with forward and
  reverse mappings by pin (0 to 25).
  """
  def new(rotor, position) do
    map = build_map(rotor.forward_mapping, position)

    %__MODULE__{
      forward_mapping: map,
      reverse_mapping: reverse_map(map),
      notch: rotor.notch,
      position: position
    }
  end

  defp build_map(rotor_map, position) do
    rotor_map
    |> Enum.into(%{}, fn {k, v} -> {pin(k, position), pin(v, position)} end)
  end

  defp pin(letter, position), do: Integer.mod(letter_index(letter) - letter_index(position), 26)

  defp letter_index(<<letter>>), do: letter - ?A

  defp reverse_map(map) do
    Enum.into(map, %{}, fn {k, v} -> {v, k} end)
  end

  def notch_lined_up?(%__MODULE__{notch: pos, position: pos}), do: true
  def notch_lined_up?(_installed_rotor), do: false

  def advance(installed_rotor) do
    installed_rotor
    |> Map.update!(:position, &advance_position/1)
    |> Map.update!(:forward_mapping, &advance_mapping/1)
    |> Map.update!(:reverse_mapping, &advance_mapping/1)
  end

  defp advance_position(<<letter>>) do
    to_string([Integer.mod(letter - ?A + 1, 26) + ?A])
  end

  defp advance_mapping(mapping) do
    Enum.into(mapping, %{}, fn {k, v} -> {Integer.mod(k + 1, 26), Integer.mod(v + 1, 26)} end)
  end

  def map_forward(installed_rotor, pin) do
    IO.puts("Mapping #{pin} to #{installed_rotor.forward_mapping[pin]}")
    installed_rotor.forward_mapping[pin]
  end

  def map_back(installed_rotor, pin) do
    IO.puts("Mapping back #{pin} to #{installed_rotor.reverse_mapping[pin]}")
    installed_rotor.reverse_mapping[pin]
  end
end

defmodule Enigma.InstalledRotor do
  @moduledoc """
  A struct representing an installed rotor, taking account of its rotary
  position.
  """

  @enforce_keys [:rotor, :forward_mapping, :reverse_mapping, :notch, :position]
  defstruct [:rotor, :forward_mapping, :reverse_mapping, :notch, :position]

  @doc """
  Given a rotor and a starting position, return a struct with forward and
  reverse mappings by pin (0 to 25).
  """
  def new(rotor, position) do
    map = build_map(rotor.forward_mapping, position)

    %__MODULE__{
      rotor: rotor,
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

  @doc """
  Returns true if the turnover notch is at the current position, allowing the
  rotor to the left to advance."
  """
  def notch_lined_up?(%__MODULE__{notch: pos, position: pos}), do: true
  def notch_lined_up?(_installed_rotor), do: false

  @doc """
  Returns a new struct, with the rotor rotated by one position."
  """
  def advance(installed_rotor) do
    position = advance_position(installed_rotor.position)
    new(installed_rotor.rotor, position)
  end

  defp advance_position(<<letter>>) do
    to_string([Integer.mod(letter - ?A + 1, 26) + ?A])
  end

  @doc """
  Returns the output pin corresponding to the given input, for the forward
  (right-to-left) path.
  """
  def map_forward(installed_rotor, pin) do
    installed_rotor.forward_mapping[pin]
  end

  @doc """
  Returns the output pin corresponding to the given input, for the backward
  (left-to-right) path.
  """
  def map_back(installed_rotor, pin) do
    installed_rotor.reverse_mapping[pin]
  end
end

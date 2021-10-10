defmodule Enigma.InstalledRotor do
  @moduledoc """
  A struct representing an installed rotor, taking account of its rotary
  position.
  """

  @enforce_keys [:forward_mapping, :reverse_mapping]
  defstruct [:forward_mapping, :reverse_mapping]

  @doc """
  Given a rotor and a starting position, return a struct with forward and
  reverse mappings by pin (0 to 25).
  """
  def new(rotor, position) do
    map = build_map(rotor.forward_mapping, position)
    %__MODULE__{forward_mapping: map, reverse_mapping: reverse_map(map)}
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
end

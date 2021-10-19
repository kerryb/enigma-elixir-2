defmodule Enigma.Rotor do
  @moduledoc """
  A struct representing a rotor in isolation.
  """

  @enforce_keys [:forward_mapping, :reverse_mapping, :notch]
  defstruct [:forward_mapping, :reverse_mapping, :notch]

  @doc """
  Given a mapping (a string of letters representing the result of mapping
  "ABC...Z") and the letter where the turnover notch is positioned, returns a
  struct with forward and reverse mappings as `Map`s, and the notch letter.
  """
  def new(mapping, notch) do
    map = build_map(mapping)
    %__MODULE__{forward_mapping: map, reverse_mapping: reverse_map(map), notch: notch}
  end

  defp build_map(mapping) do
    ["ABCDEFGHIJKLMNOPQRSTUVWXYZ", mapping]
    |> Enum.map(&String.codepoints/1)
    |> Enum.zip()
    |> Enum.into(%{})
  end

  defp reverse_map(map) do
    Enum.into(map, %{}, fn {k, v} -> {v, k} end)
  end

  @doc """
  Returns a new struct, with mappings resulting from advancing the alphabet
  ring by _position_ steps.
  """
  def with_ring_position(rotor, position) do
    rotor
    |> Map.update!(:forward_mapping, &advance_mapping(&1, position))
    |> Map.update!(:reverse_mapping, &advance_mapping(&1, position))
    |> Map.update!(:notch, &advance_letter(&1, position))
  end

  defp advance_mapping(mapping, position) do
    Enum.into(mapping, %{}, fn {k, v} ->
      {advance_letter(k, position), advance_letter(v, position)}
    end)
  end

  defp advance_letter(<<letter>>, position) do
    to_string([Integer.mod(letter - ?A + position, 26) + ?A])
  end
end

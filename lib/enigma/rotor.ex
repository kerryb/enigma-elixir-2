defmodule Enigma.Rotor do
  @moduledoc """
  A struct representing a rotor in isolation.
  """

  @enforce_keys [:forward_mapping, :reverse_mapping]
  defstruct [:forward_mapping, :reverse_mapping]

  @doc """
  Given a mapping (a string of letters representing the result of mapping
  "ABC...Z") and the letter where the turnover notch is positioned, returns a
  struct with forward and reverse mappings as `Map`s, and the notch letter.
  """
  def new(mapping, _notch) do
    map = build_map(mapping)
    %__MODULE__{forward_mapping: map, reverse_mapping: reverse_map(map)}
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
end

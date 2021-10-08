defmodule Enigma.Rotor do
  @moduledoc """
  A struct representing a rotor in isolation.
  """

  defstruct [:forward_mapping]

  @doc """
  Given a mapping (a string of letters representing the result of mapping
  "ABC...Z") and the letter where the turnover notch is positioned, returns a
  struct with forward and reverse mappings as `Map`s, and the notch letter.
  """
  def new(mapping, _notch) do
    map = build_map(mapping)
    %__MODULE__{forward_mapping: map}
  end

  defp build_map(mapping) do
    ["ABCDEFGHIJKLMNOPQRSTUVWXYZ", mapping]
    |> Enum.map(&String.codepoints/1)
    |> Enum.zip()
    |> Enum.into(%{})
  end
end

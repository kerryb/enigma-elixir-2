defmodule Enigma.Reflector do
  @moduledoc """
  A struct representing a reflector in isolation. This version does not have a
  turnover notch.
  """

  @enforce_keys [:mapping]
  defstruct [:mapping]

  @doc """
  Given a mapping (a string of letters representing the result of mapping
  "ABC...Z"), returns a struct with the mapping as a `Map`.

  Note that the provided map must be symmetrical (eg if A maps to X, then X
  must map to A).
  """
  def new(mapping) do
    map = build_map(mapping)
    %__MODULE__{mapping: map}
  end

  defp build_map(mapping) do
    ["ABCDEFGHIJKLMNOPQRSTUVWXYZ", mapping]
    |> Enum.map(&String.codepoints/1)
    |> Enum.zip()
    |> Enum.into(%{})
  end
end

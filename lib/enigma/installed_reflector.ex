defmodule Enigma.InstalledReflector do
  @moduledoc """
  A struct representing an installed reflector.
  """

  @enforce_keys [:forward_mapping, :reverse_mapping]
  defstruct [:forward_mapping, :reverse_mapping]

  @doc """
  Given a reflector, return a struct with identical forward and reverse
  mappings by pin (0 to 25).
  """
  def new(reflector) do
    map = build_map(reflector.mapping)
    %__MODULE__{forward_mapping: map, reverse_mapping: map}
  end

  defp build_map(reflector_map) do
    Enum.into(reflector_map, %{}, fn {k, v} -> {letter_index(k), letter_index(v)} end)
  end

  defp letter_index(<<letter>>), do: letter - ?A
end

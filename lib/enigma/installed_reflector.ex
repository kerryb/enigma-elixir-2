defmodule Enigma.InstalledReflector do
  @moduledoc """
  A struct representing an installed reflector.
  """

  @enforce_keys [:mapping]
  defstruct [:mapping]

  @doc """
  Given a reflector, return a struct with mapping by pin (0 to 25).
  """
  def new(reflector) do
    %__MODULE__{mapping: build_map(reflector.mapping)}
  end

  defp build_map(reflector_map) do
    Enum.into(reflector_map, %{}, fn {k, v} -> {letter_index(k), letter_index(v)} end)
  end

  defp letter_index(<<letter>>), do: letter - ?A

  def map(installed_reflector, pin) do
    IO.puts("Reflecting #{pin} to #{installed_reflector.mapping[pin]}")
    installed_reflector.mapping[pin]
  end
end

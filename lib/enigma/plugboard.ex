defmodule Enigma.Plugboard do
  @moduledoc """
  A struct representing a plugboard, with optional patch cables in position.
  """

  @enforce_keys [:mapping]
  defstruct [:mapping]

  @default_map Enum.into(0..25, %{}, &{&1, &1})
  @doc """
  Given a list of pairs of patched letters (eg `[{"A", "E"}, {"G", "X"}]`),
  returns a struct with a mapping by position (0 to 25). The mapping is
  symmetrical.
  """
  def new(patches) do
    map = Enum.reduce(patches, @default_map, &add_patch/2)
    %__MODULE__{mapping: map}
  end

  defp add_patch({<<letter_1>>, <<letter_2>>}, mapping) do
    position_1 = letter_1 - ?A
    position_2 = letter_2 - ?A
    %{mapping | position_1 => position_2, position_2 => position_1}
  end

  def map(plugboard, pin) do
    plugboard.mapping[pin]
  end
end

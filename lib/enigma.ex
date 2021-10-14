defmodule Enigma do
  alias Enigma.{Reflector, Rotor}

  @rotor_i Rotor.new("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q")
  @rotor_ii Rotor.new("AJDKSIRUXBLHWTMCQGZNPYFVOE", "E")
  @rotor_iii Rotor.new("BDFHJLCPRTXVZNYEIWGAKMUSQO", "V")
  @rotor_iv Rotor.new("ESOVPZJAYQUIRHXLNFTGKDCMWB", "J")
  @rotor_v Rotor.new("VZBRGITYUPSDNHLXAWMJQOFECK", "Z")

  @reflector_a Reflector.new("EJMZALYXVBWFCRQUONTSPIKHGD")
  @reflector_b Reflector.new("YRUHQSLDPXNGOKMIEBFZCWVJAT")
  @reflector_c Reflector.new("FVPJIAOYEDRZXWGCTKUQSBNMHL")

  def rotor_i, do: @rotor_i
  def rotor_ii, do: @rotor_ii
  def rotor_iii, do: @rotor_iii
  def rotor_iv, do: @rotor_iv
  def rotor_v, do: @rotor_v

  def reflector_a, do: @reflector_a
  def reflector_b, do: @reflector_b
  def reflector_c, do: @reflector_c
end

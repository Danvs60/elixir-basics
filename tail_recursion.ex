defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      ?\s -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      0b0000 -> ?\s
    end
  end

  def encode(dna) do
    encode_dna(dna)
  end

  defp encode_dna(dna, encoded \\ <<>>)
  defp encode_dna([], encoded), do: encoded
  defp encode_dna([nucleotide | tail], encoded) do
    encode_dna(tail, <<encoded::bitstring, encode_nucleotide(nucleotide)::4>>)
  end

  def decode(dna) do
    decode_dna(dna)
  end

  defp decode_dna(dna, decoded \\ [])
  defp decode_dna(<<>>, decoded), do: decoded
  defp decode_dna(<<nucleotide::4, rest::bitstring>>, decoded) do
    decode_dna(rest, decoded ++ [decode_nucleotide(nucleotide)])
  end
end

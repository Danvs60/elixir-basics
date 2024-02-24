defmodule Username do

  @spec sanitize(charlist()) :: charlist()
  def sanitize([]), do: ~c//
  def sanitize([char | list]) do
    sanitized =
      case char do
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        ?_ -> '_'
        c when c >= ?a and c <= ?z -> [c]
        _ -> ''
      end
    sanitized ++ sanitize(list)
  end
end

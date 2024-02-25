defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    access_key(data, String.split(path, "."))
  end
  defp access_key(data, [key | []]), do: data[key]
  defp access_key(data, [key | tail]), do: access_key(data[key], tail)

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end

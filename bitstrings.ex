defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    find_minimum_bit_size(color_count)
  end

  @doc false
  defp find_minimum_bit_size(colour_count, size \\ 1) do
    if Integer.pow(2, size) >= colour_count do
      size
    else
      find_minimum_bit_size(colour_count, size + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    palette_size = palette_bit_size(color_count)
    <<pixel_color_index::size(palette_size), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count), do: nil
  def get_first_pixel(picture, color_count) do
    palette_size = palette_bit_size(color_count)
    <<pixel::size(palette_size), _rest::bitstring>> = picture
    pixel
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>
  def drop_first_pixel(picture, color_count) do
    palette_size = palette_bit_size(color_count)
    <<_pixel::size(palette_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end

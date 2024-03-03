defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.at(@planetary_classes, trunc(:rand.uniform() * length(@planetary_classes)))
  end

  def random_ship_registry_number() do
    "NCC-#{trunc(Enum.random(1000..9999))}"
  end

  def random_stardate() do
    42000.0 - :rand.uniform() * 1000.0
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate])
    |> List.to_string()
  end
end

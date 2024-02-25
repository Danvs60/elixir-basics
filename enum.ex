defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price), :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price === nil))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn item ->
        Map.update!(item, :name, &String.replace(&1, old_word, new_word))
      end)
  end

  def increase_quantity(item, count) do
    Map.update!(item, :quantity_by_size, fn quantities -> Enum.into(quantities, Map.new(), fn {k, v} -> {k, v + count} end) end)
  end

  def total_quantity(item) do
    Map.get(item, :quantity_by_size)
    |> Enum.reduce(0, fn {_k, v}, acc -> v + acc end)
  end
end

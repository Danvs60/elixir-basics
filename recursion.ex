defmodule BirdCount do
  def today([]), do: nil
  def today([today | _past]), do: today

  def increment_day_count([]), do: [1]
  def increment_day_count([today | past]), do: [today + 1 | past]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _past]), do: true
  def has_day_without_birds?([_today | past]), do: has_day_without_birds?(past)

  def total([]), do: 0
  def total([today | past]) do
    today + total(past)
  end

  def busy_days([]), do: 0
  def busy_days([today | past]) when today >= 5, do: 1 + busy_days(past)
  def busy_days([_today | past]), do: 0 + busy_days(past)
end

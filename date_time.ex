defmodule LibraryFees do
  @moduledoc """
  Extension for library software to calculate late fees.

  System uses exact date and time in ISO8601 format.
  System timezone is GMT (UTC+0), no daylight savings or different time zone requirements.
  """

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    Time.compare(NaiveDateTime.to_time(datetime), ~T[12:00:00]) == :lt
  end

  def return_date(checkout_datetime) do
    return_period = if before_noon?(checkout_datetime), do: 28, else: 29
    checkout_datetime
    |> NaiveDateTime.add(return_period * 24 * 60 * 60)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    1 == datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
  end

  def calculate_late_fee(checkout, return, rate) do
    rate = if monday?(datetime_from_string(return)), do: rate * 0.5, else: rate
    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(datetime_from_string(return))
    |> Kernel.*(rate)
    |> trunc()
  end
end

defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    Integer.to_string(Map.get(remote_car, :distance_driven_in_meters)) <>" meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"
  def display_battery(%RemoteControlCar{} = remote_car) do
    "Battery at " <> Integer.to_string(Map.get(remote_car, :battery_percentage)) <> "%"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = remote_car), do: %RemoteControlCar{remote_car | distance_driven_in_meters: 0}
  def drive(%RemoteControlCar{battery_percentage: bp, distance_driven_in_meters: d} = remote_car) do
    %RemoteControlCar{
      %RemoteControlCar{
        remote_car | battery_percentage: bp - 1
      } | distance_driven_in_meters: d + 20
    }
  end
end

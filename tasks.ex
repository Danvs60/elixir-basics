defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    %{input: input, pid: spawn_link(fn -> calculator.(input) end)}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _reason} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    initial_flag_value = Process.flag(:trap_exit, true)
    calculations = Enum.map(inputs, &start_reliability_check(calculator, &1))
                    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    Process.flag(:trap_exit, initial_flag_value)
    calculations
  end

  def correctness_check(calculator, inputs) do
    calculations = Enum.map(inputs, &Task.async(fn -> calculator.(&1) end))
    results = Enum.map(calculations, &Task.await(&1, 100))
    results
  end
end

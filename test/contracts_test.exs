defmodule ContractsTest do
  use ExUnit.Case

  defmodule Tank do
    defstruct level: 0, max_level: 10, in_valve: :closed, out_valve: :closed

    use Contracts

    requires not full?(tank) && tank.in_valve == :open && tank.out_valve == :closed
    ensures full?(result) && result.in_valve == :closed && result.out_valve == :closed
    def fill(tank) do
      %Tank{tank | level: 10, in_valve: :closed}
    end

    requires tank.in_valve == :closed && tank.out_valve == :open
    ensures empty?(result) && result.in_valve == :closed && result.out_valve == :closed
    def empty(tank) do
      %Tank{tank | level: 1, out_valve: :closed}
      # %Tank{tank | level: 0, out_valve: :closed} # correct implementation
    end

    def full?(tank) do
      tank.level == tank.max_level
    end

    def empty?(tank) do
      tank.level == 0
    end
  end

  if Contracts.Config.is_enabled? do
    describe "failing precondition" do
      test "fill/1 function with a :closed in_valve raises" do
        tank = %Tank{level: 10, in_valve: :closed}
        assert_raise RuntimeError, "Precondition not met: not full?(tank) && tank.in_valve() == :open && tank.out_valve() == :closed", fn->
          Tank.fill(tank)
        end
      end
    end

    describe "failing postcondition" do
      test "buggy empty/1 function does not correctly empty the tank" do
        tank = %Tank{level: 10, out_valve: :open}
        assert_raise RuntimeError, "Postcondition not met: empty?(result) && result.in_valve() == :closed && result.out_valve() == :closed", fn->
          Tank.empty(tank)
        end
      end
    end
  end

  unless Contracts.Config.is_enabled? do
    describe "failing precondition" do
      test "fill/1 function with a :closed in_valve raises" do
        tank = %Tank{level: 9, in_valve: :closed}
        tank = Tank.fill(tank)
        # because pre-condition is disabled, the function executes and fills the tank...
        assert Tank.full?(tank)
      end
    end
    describe "failing postcondition is disabled" do
      test "buggy empty/1 function does not correctly empty the tank" do
        tank = %Tank{level: 10, out_valve: :open}
        tank = Tank.empty(tank)
        # because the function is buggy and post-condition is disabled, the tank is not really empty
        refute Tank.empty?(tank)
      end
    end
  end
end

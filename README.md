Contracts
=========

[![Build status](https://travis-ci.org/ruby2elixir/elixir-contracts.svg "Build status")](https://travis-ci.org/ruby2elixir/elixir-contracts)
[![Hex version](https://img.shields.io/hexpm/v/contracts.svg "Hex version")](https://hex.pm/packages/contracts)
![Hex downloads](https://img.shields.io/hexpm/dt/contracts.svg "Hex downloads")


Design by Contract for Elixir


Usage
======

```elixir
use Contracts

requires x > 0
ensures (result * result) <= x && (result+1) * (result+1) > x
def sqrt(x) do
  :math.sqrt(x)
end
```




### Bigger example

```elixir
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
```

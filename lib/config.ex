defmodule Contracts.Config do
  def is_enabled? do
    Application.get_env(:contracts, :enabled)
  end
end

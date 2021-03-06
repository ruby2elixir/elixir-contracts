defmodule Contracts.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :contracts,
     version: @version,
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:earmark, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end


  defp package do
    [
     maintainers: ["Guillermo Iguaran", "Elba Sanchez Marquez", "Roman Heinrich"],
     licenses: ["MIT License"],
     description: "Design by Contracts for Elixir",
     links: %{
       github: "https://github.com/ruby2elixir/elixir-contracts",
       docs: "http://hexdocs.pm/contracts/#{@version}/"
     }
    ]
  end
end

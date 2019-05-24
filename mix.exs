defmodule StructCop.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :struct_cop,
      deps: deps(),
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      version: @version
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:beam_inspect, "~> 0.1", only: [:dev, :test]},
      {:ecto, "~> 3.0"}
    ]
  end

  def elixirc_paths(:test), do: ["lib", "test/support"]
  def elixirc_paths(_), do: ["lib"]
end

defmodule StructCop.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :struct_cop,
      deps: deps(),
      elixir: "~> 1.8",
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
      {:ecto, "~> 3.0"}
    ]
  end
end

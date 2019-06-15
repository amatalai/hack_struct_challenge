defmodule HackStructChallenge.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :hack_struct_challenge,
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
      {:beam_inspect, "~> 0.1", only: [:dev, :test]}
    ]
  end
end

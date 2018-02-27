defmodule Aquabyte.MixProject do
  use Mix.Project

  def project do
    [
      app: :aquabyte,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [mod: {Aquabyte, []}]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:flow, "~> 0.13"},
      {:ex_image_info, "~> 0.2.2"}
    ]
  end
end

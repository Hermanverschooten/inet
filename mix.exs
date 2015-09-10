defmodule Inet.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [app: :inet,
     version: @version,
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     package: package,
     name: "Macadd",
     docs: [
       source_ref: "v#{@version}",
       source_url: "https://github.com/Hermanverschooten/inet"
     ],
     test_paths: ["test"]
   ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:postgrex]]
  end

  defp description do
    """
    Ecto types for the postgreSQL inet type.
    """
  end

  defp package do
    [
      files: ~w(lib README.mv mix.exs),
      contributors: ["Herman verschooten"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Hermanverschooten/inet"}
      ]
  end

  defp deps do
    [
      {:postgrex, "~> 0.9"},
      {:ecto, "~> 1.0"},
      {:eh, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.8", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev}
    ]
  end
end

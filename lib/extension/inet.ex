defmodule Extension.Inet do
  alias Postgrex.TypeInfo

  @behaviour Postgrex.Extension

  @moduledoc """
  A Postgrex.Extension enabling the use of the inet data type.

  Add this module as en extension when establishing your Postgrex connection:

      Postgrex.Connection.start_link(
        database: "inet_test",
        extensions: [{ Inet.Extension, {}}])

  Then you can do Ecto.Migration like this:

      defmodule MyApp.Repo.Migrations.CreateComputer do
        use Ecto.Migration

        def change do
          create table(:computers) do
            add :mac, :inet
            # other fields
          end
        end
      end

  You can also define Ecto.Models using the matching custom Ecto.Type:

      defmodule MyApp.Computer do
        use MyApp.Web, :model

        schema "computers" do
          field :mac, :Inet
          # other fields
        end
      end
  """

  def init(parameters, _opts), do: parameters

  def matching(_library), do: [type: "inet"]

  def format(_), do: :text

  def encode(%TypeInfo{type: "inet"}, binary, _types, _opts), do: binary

  def decode(%TypeInfo{type: "inet"}, binary, _types, _opts), do: binary
end


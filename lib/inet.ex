defmodule Inet do
  alias Postgrex.TypeInfo

  @behaviour Postgrex.Extension

  @inet ~w(inet cidr macaddr)

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

  def matching(_library), do: Enum.zip(Stream.cycle([:type]), @inet)

  def format(_), do: :text

  def encode(%TypeInfo{type: type}, binary, _types, _opts) when type in @inet, do: binary

  def decode(%TypeInfo{type: type}, binary, _types, _opts) when type in @inet, do: binary

end

defmodule Inet.Base do
  @moduledoc """
  Base module for Inet custom ecto types
  """

  @doc """
  Set up basic functionality for the network address types.

  This extends the calling module by defining implementations for

  * type/0
  * blank?/0
  * cast/1
  * load/1
  * dump/1
  """

  defmacro __using__(_opts) do
    ecto_type = __CALLER__.module
                |> Atom.to_string
                |> String.replace(~r(.+\.),"")
    inet_type = ecto_type
                |> String.downcase
                |> String.to_atom

    quote bind_quoted: [inet_type: inet_type, ecto_type: ecto_type] do
      @behaviour Ecto.Type

      @moduledoc """
      Definition for the #{inet_type} module.

      How to use this in an Ecto.Model

      defmodule MyApp.thing do
      use MyApp.web, :model

      schema "things" do
      field :#{inet_type}, Inet.#{ecto_type}
      #other fields
      end
      end
      """

      def type, do: unquote(inet_type)

      defdelegate blank?, to: Ecto.Type

      def cast(nil), do: :error
      def cast(inet), do: {:ok, to_string(inet)}
      def load(inet), do: {:ok, to_string(inet)}
      def dump(inet), do: {:ok, to_string(inet)}
    end
  end
end

defmodule Inet.INET, do: use(Inet.Base)
defmodule Inet.CIDR, do: use(Inet.Base)
defmodule Inet.MACADDR, do: use(Inet.Base)

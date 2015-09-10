defmodule Inet do
  @behaviour Ecto.Type

  @moduledoc """
    Definition for the inet module.

    How to use in an Ecto.Model

      defmodule MyApp.Computer do
        use MyApp.Web, :model

        schema "computers" do
          field :ip, :Inet
          # other fields
        end
      end
  """

  def type, do: :inet

  defdelegate blank?, to: Ecto.Type

  def cast(nil), do: :error

  def cast(ip), do: {:ok, to_string(ip)}
  def load(ip), do: {:ok, to_string(ip)}
  def dump(ip), do: {:ok, to_string(ip)}

end

defmodule InetTest do
  use ExUnit.Case, async: true
  import Inet.TestHelper
  alias Postgrex.Connection, as: P

  setup do
    options = Keyword.merge(conn_options, [extensions: [{Inet, {}}]])
    {:ok, pid} = P.start_link(options)
    {:ok, [pid: pid]}
  end

  test "encode and decode ip address", context do
    assert [["192.168.1.1"]] =
      query(context[:pid], "SELECT $1::inet", ["192.168.1.1"])

    assert [["192.168.1.1/24"]] =
      query(context[:pid], "SELECT $1::inet", ["192.168.1.1/24"])

    assert [["::ffff:10.2.3.4"]] =
      query(context[:pid], "SELECT $1::inet", ["::FFFF:10.2.3.4"])
  end

end

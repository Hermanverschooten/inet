defmodule Inet.MACADDRTest do
  use ExUnit.Case, async: true

  @test_macaddr "a0:b1:2c:3d:4e"

  test "cast" do
    assert Inet.MACADDR.cast(@test_macaddr) == {:ok, @test_macaddr}
    assert Inet.MACADDR.cast(nil) == :error
  end

  test "load" do
    assert Inet.MACADDR.load(@test_macaddr) == {:ok, @test_macaddr}
  end

  test "dump" do
    assert Inet.MACADDR.dump(@test_macaddr) == {:ok, @test_macaddr}
  end
end

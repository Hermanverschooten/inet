defmodule Inet.INETTest do
  use ExUnit.Case, async: true

  @test_inet "192.168.1.1"

  test "cast" do
    assert Inet.INET.cast(@test_inet) == {:ok, @test_inet}
    assert Inet.INET.cast(nil) == :error
  end

  test "load" do
    assert Inet.INET.load(@test_inet) == {:ok, @test_inet}
  end

  test "dump" do
    assert Inet.INET.dump(@test_inet) == {:ok, @test_inet}
  end
end

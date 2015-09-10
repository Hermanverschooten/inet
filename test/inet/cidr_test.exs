defmodule Inet.CIDRTest do
  use ExUnit.Case, async: true

  @test_cidr "192.168.1"

  test "cast" do
    assert Inet.CIDR.cast(@test_cidr) == {:ok, @test_cidr}
    assert Inet.CIDR.cast(nil) == :error
  end

  test "load" do
    assert Inet.CIDR.load(@test_cidr) == {:ok, @test_cidr}
  end

  test "dump" do
    assert Inet.CIDR.dump(@test_cidr) == {:ok, @test_cidr}
  end
end

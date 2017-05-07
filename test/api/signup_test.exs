defmodule Api.SignupTest do
  use ExUnit.Case
  use Plug.Test

  @opts Tinysql.Router.init([])

  test "homepage returns success" do
    conn = conn(:get, "/")
    conn = Tinysql.Router.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
  end
end

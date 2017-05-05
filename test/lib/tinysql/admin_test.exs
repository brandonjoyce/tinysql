defmodule Tinysql.AdminTest do
  use ExUnit.Case
  alias Tinysql.Admin
  alias Tinysql.Util

  test "creating a database" do
    Admin.create_database("test_database")
    opts = Util.connection_opts(database: "test_database")
    assert {:ok, pid} = Postgrex.start_link(opts)
    Postgrex.transaction(pid, fn(conn) ->
      Postgrex.query(conn, "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';", [])
    end)
  end
end

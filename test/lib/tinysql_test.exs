require Ecto.Query
defmodule TinysqlTest do
  use ExUnit.Case
  alias Tinysql.Util

  setup do
    Tinysql.create_schema("test_schema")
    :ok
  end

  test "querying the test schema" do
    schema = "test_schema"
    table = "customers"
    Tinysql.drop_table(schema, table)
    Tinysql.create_table(schema, table, %{
      "first_name" => [type: "varchar", limit: 50, null: false, default: "default"],
    })
    query = Ecto.Query.from(c in table, select: c.first_name)
    query = %{query | prefix: schema}
    Tinysql.Repo.all(query)
  end
end

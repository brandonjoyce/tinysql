defmodule Tinysql do
  use Application
  alias Tinysql.Repo

  def start(_type, _args) do
    Tinysql.Supervisor.start_link()
  end

  alias Tinysql.Util

  def create_schema(schema) do
    schema = clean_name(schema)
    {:ok, _} = Ecto.Adapters.SQL.query(Repo, "CREATE SCHEMA IF NOT EXISTS #{schema}", [])
  end

  def drop_schema(schema) do
    schema = clean_name(schema)
    {:ok, _} = Ecto.Adapters.SQL.query(Repo, "DROP SCHEMA IF EXISTS #{schema}", [])
  end

  def create_table(schema, table_name, opts) when is_map(opts) do
    schema = clean_name(schema)
    table_name = clean_name(table_name)
    {:ok, _} = Ecto.Adapters.SQL.query(Repo, "CREATE TABLE IF NOT EXISTS #{schema}.#{table_name} ()", [])
  end

  def drop_table(schema, table_name) do
    schema = clean_name(schema)
    table_name = clean_name(table_name)
    {:ok, _} = Ecto.Adapters.SQL.query(Repo, "DROP TABLE IF EXISTS #{schema}.#{table_name}", [])
  end

  defp clean_name(schema) do
    schema
    |> String.replace(~r/[^a-zA-Z_]/, "")
    |> Macro.underscore
  end
end

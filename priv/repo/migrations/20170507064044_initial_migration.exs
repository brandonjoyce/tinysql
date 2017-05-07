defmodule Tinysql.Repo.Migrations.InitialMigration do
  use Ecto.Migration

  def change do
    create table(:schemas) do
      add :name, :string, size: 200, null: false
      timestamps()
    end

    create table(:tables) do
      add :schema_id, references(:schemas)
      add :name, :string, size: 200, null: false
      timestamps()
    end

    create table(:columns) do
      add :table_id, references(:tables)
      add :name, :string, size: 200, null: false
      add :type, :string, size: 50, null: false
      add :primary_key, :boolean
      add :default, :string
    end
  end
end

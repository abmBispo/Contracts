defmodule Contracts.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :name, :string, null: false
      add :surname, :string, null: false
      add :tax_id, :string, null: false
      add :telephone, :string, null: false

      timestamps()
    end
  end
end

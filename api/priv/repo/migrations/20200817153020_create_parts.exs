defmodule Contracts.Repo.Migrations.CreateParts do
  use Ecto.Migration

  def change do
    create table(:parts) do
      add :name, :string, null: false
      add :surname, :string, null: false
      add :email, :string, null: false
      add :tax_id, :string, null: false
      add :telephone, :string, null: false

      timestamps()
    end
  end
end

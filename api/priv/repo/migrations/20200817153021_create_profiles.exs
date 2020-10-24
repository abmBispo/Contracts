defmodule Contracts.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :account_id, references(:accounts, on_delete: :nothing), null: false
      add :name, :string, null: false
      add :tax_id, :string, null: false
      add :telephone, :string, null: false

      timestamps()
    end
  end
end

defmodule Contracts.Repo.Migrations.CreateContracts do
  use Ecto.Migration

  def change do
    create table(:contracts) do
      add :title, :string, null: false
      add :begin, :date, null: false
      add :end, :date, null: false
      add :file, :string, null: false

      timestamps()
    end
  end
end

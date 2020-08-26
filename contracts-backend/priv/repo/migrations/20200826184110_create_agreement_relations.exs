defmodule Contracts.Repo.Migrations.CreateAgreementRelations do
  use Ecto.Migration

  def change do
    create table(:agreement_relations) do
      add :part, references(:part_id, on_delete: :nothing), null: false
      add :contract, references(:contract_id, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:agreement_relations, [:part])
    create index(:agreement_relations, [:contract])
  end
end

defmodule Contracts.Repo.Migrations.CreateAgreementRelations do
  use Ecto.Migration

  def change do
    create table(:agreement_relations) do
      add :part_id, references(:parts, on_delete: :nothing), null: false
      add :contract_id, references(:contracts, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:agreement_relations, [:part_id, :contract_id], name: :unique_contract_part_index)
  end
end

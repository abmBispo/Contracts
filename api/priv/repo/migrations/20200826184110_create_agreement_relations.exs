defmodule Contracts.Repo.Migrations.CreateAgreementRelations do
  use Ecto.Migration

  def change do
    create table(:agreement_relations) do
      add :account_id, references(:accounts, on_delete: :nothing), null: false
      add :contract_id, references(:contracts, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:agreement_relations, [:account_id, :contract_id], name: :unique_contract_account_index)
  end
end

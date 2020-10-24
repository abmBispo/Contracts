defmodule Contracts.Agreements.Relation do
  use Ecto.Schema
  import Ecto.Changeset

  alias Contracts.Agreements.{
    Part.Account,
    Contract
  }

  @required_fields [:contract_id, :account_id]

  schema "agreement_relations" do
    belongs_to :account, Account
    belongs_to :contract, Contract

    timestamps()
  end

  def changeset(relation, attrs) do
    relation
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:unique_contract_account_index,
      name: :unique_contract_account_index,
      message: "The part has already been added to contract!"
    )
  end
end

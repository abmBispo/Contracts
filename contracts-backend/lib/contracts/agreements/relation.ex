defmodule Contracts.Agreements.Relation do
  use Ecto.Schema
  import Ecto.Changeset

  alias Contracts.Agreements.{
    Part,
    Contract
  }

  @required_fields [:contract_id, :part_id]

  schema "agreement_relations" do
    belongs_to :part, Part
    belongs_to :contract, Contract

    timestamps()
  end

  @doc false
  def changeset(relation, attrs) do
    relation
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:unique_contract_part_index, name: :unique_contract_part_index)
  end
end

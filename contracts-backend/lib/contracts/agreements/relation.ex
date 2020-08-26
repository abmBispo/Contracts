defmodule Contracts.Agreements.Relation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "agreement_relations" do
    field :part, :id
    field :contract, :id

    timestamps()
  end

  @doc false
  def changeset(relation, attrs) do
    relation
    |> cast(attrs, [])
    |> validate_required([])
  end
end

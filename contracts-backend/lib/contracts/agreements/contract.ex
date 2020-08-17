defmodule Contracts.Agreements.Contract do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contracts" do
    field :begin, :date
    field :end, :date
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(contract, attrs) do
    contract
    |> cast(attrs, [:title, :begin, :end])
    |> validate_required([:title, :begin, :end])
  end
end

defmodule Contracts.Agreements.Part do
  use Ecto.Schema
  import Ecto.Changeset
  alias Contracts.Agreements.Contract

  schema "parts" do
    field :email, :string
    field :name, :string
    field :surname, :string
    field :tax_id, :string
    field :telephone, :string

    timestamps()
  end

  @doc false
  def changeset(part, attrs) do
    part
      |> cast(attrs, [:name, :surname, :email, :tax_id, :telephone])
      |> validate_required([:name, :surname, :email, :tax_id, :telephone])
  end
end

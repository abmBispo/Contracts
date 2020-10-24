defmodule Contracts.Agreements.Part.Profile do
  use Ecto.Schema
  import Ecto.Changeset


  @required_fields [:name, :surname, :email, :tax_id, :telephone]

  schema "profiles" do
    field :full_name, :string
    field :tax_id, :string
    field :telephone, :string

    timestamps()
  end

  def changeset(part, attrs) do
    part
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end

defmodule Contracts.Agreements.Part.Registration do
  use Ecto.Schema
  import Ecto.Changeset

  alias Contracts.Agreements.Part.Registration

  @required_fields [:name, :surname, :email, :tax_id, :telephone]

  embedded_schema do
    field :email
    field :name
    field :surname
    field :tax_id
    field :telephone
  end

  def change_set(params \\ %{}) do
    %Registration{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end

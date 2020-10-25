defmodule Contracts.Agreements.Part.Registration do
  use Ecto.Schema
  import Ecto.Changeset

  alias Contracts.Agreements.Part.{
    Registration,
    Account,
    Profile
  }

  @required_fields [:name, :surname, :email, :tax_id, :telephone]

  embedded_schema do
    field :email
    field :name
    field :surname
    field :tax_id
    field :telephone
  end

  def changeset(registration, params \\ %{}) do
    registration
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  def to_account(%Ecto.Changeset{valid?: true, changes: data}) do
    %Account{email: data.email}
  end

  def to_profile(%Ecto.Changeset{valid?: true, changes: data}) do
    %Profile{
      name: "#{data.name} #{data.surname}",
      tax_id: data.tax_id,
      telephone: data.telephone
    }
  end

  def mount_part(%{profile: profile, account: account}) do
    %Account{
      id: account.id,
      email: account.email,
      profile: %{
        name: profile.name,
        tax_id: profile.tax_id,
        telephone: profile.telephone
      },
    }
  end
end

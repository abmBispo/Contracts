defmodule Contracts.Agreements.Part.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Contracts.Agreements.{
    Part.Profile,
    Relation
  }

  @fields [:email, :password]

  schema "accounts" do
    field :email, :string
    field :password, :string
    has_one :profile, Profile
    has_many :relations, Relation
    has_many :contracts, through: [:relations, :contract]

    timestamps()
  end

  def changeset(account, :create, attrs) do
    account
    |> cast(attrs, @fields)
    |> put_change(:password, "123456")
    |> put_password()
    |> validate_required(@fields)
    |> unique_constraint(:email)
  end

  def changeset(account, :update, attrs) do
    profile = Profile.changeset(account.profile, :update, %{
      id: account.profile.id,
      name: attrs["name"],
      tax_id: attrs["tax_id"],
      telephone: attrs["telephone"]
    })

    account
    |> cast(attrs, @fields)
    |> put_assoc(:profile, profile)
    |> validate_required(@fields)
    |> unique_constraint(:email)
  end

  defp put_password(%{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password(changeset), do: changeset
end

defmodule Contracts.Agreements.Part.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Contracts.Agreements.Relation

  @fields [:email, :password_digest]

  schema "accounts" do
    field :email, :string
    field :password_digest, :string
    has_many :relations, Relation
    has_many :contracts, through: [:relations, :contract]

    timestamps()
  end

  def changeset(part, attrs) do
    part
    |> cast(attrs, @fields)
    |> put_password_digest()
    |> validate_required(@fields)
  end

  defp put_password_digest(%{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_digest: Argon2.hash_pwd_salt(password))
  end

  defp put_password_digest(changeset), do: changeset
end

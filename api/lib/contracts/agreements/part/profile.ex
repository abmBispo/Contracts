defmodule Contracts.Agreements.Part.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Contracts.Agreements.Part.Account

  @fields [:name, :tax_id, :telephone]

  schema "profiles" do
    belongs_to :account, Account
    field :name, :string
    field :tax_id, :string
    field :telephone, :string

    timestamps()
  end

  def changeset(profile, attrs \\ %{}) do
    profile
    |> cast(attrs, @fields)
    |> put_assoc(:account, attrs.account)
    |> validate_required(@fields)
  end
end

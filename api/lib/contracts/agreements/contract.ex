defmodule Contracts.Agreements.Contract do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Contracts.Agreements.{
    Uploader.File,
    Part,
    Relation
  }

  schema "contracts" do
    field :begin, :date
    field :end, :date
    field :title, :string
    field :file, File.Type
    has_many :relations, Relation
    has_many :parts, through: [:relations, :account]

    timestamps()
  end

  @doc false
  def changeset(contract, attrs) do
    attrs =
      if attrs["file"],
        do: %{
          attrs
          | "file" => %{
              attrs["file"]
              | filename: random_string() <> "-" <> attrs["file"].filename
            }
        },
        else: attrs

    contract
    |> cast(attrs, [:title, :begin, :end])
    |> cast_attachments(attrs, [:file])
    |> validate_required([:title, :begin, :end, :file])
  end

  defp random_string() do
    :crypto.strong_rand_bytes(8)
    |> Base.url_encode64()
    |> binary_part(0, 8)
  end
end

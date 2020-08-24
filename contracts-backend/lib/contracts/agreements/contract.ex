defmodule Contracts.Agreements.Contract do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Contracts.Agreements.Uploader.File

  schema "contracts" do
    field :begin, :date
    field :end, :date
    field :title, :string
    field :file, File.Type

    timestamps()
  end

  @doc false
  def changeset(contract, attrs) do
    attrs = %{ attrs | "file" => %{ attrs["file"] | filename: random_string <> "-" <> attrs["file"].filename }}

    contract
      |> cast(attrs, [:title, :begin, :end])
      |> cast_attachments(attrs, [:file])
      |> validate_required([:title, :begin, :end, :file])
  end

  defp random_string() do
    :crypto.strong_rand_bytes(8)
      |> Base.url_encode64
      |> binary_part(0, 8)
  end
end

defmodule Contracts.Agreements.Uploader.File do
  use Arc.Definition
  use Arc.Ecto.Definition

  @extension_whitelist ~w(.pdf .doc)

  def acl(:original, _), do: :public_read

  def validate({file, _}) do
    file_extension =
      file.file_name
      |> Path.extname
      |> String.downcase

    Enum.member?(@extension_whitelist, file_extension)
  end

  def filename(_, {file, _}) do
    file.file_name
      |> Path.basename('.pdf')
      |> Path.basename('.doc')
  end

  def storage_dir(_, {_, contract}) do
    "priv/static/files/contracts/"
  end

  def default_url(:original), do: ""
end

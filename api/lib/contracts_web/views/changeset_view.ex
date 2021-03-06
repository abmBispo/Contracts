defmodule ContractsWeb.ChangesetView do
  use ContractsWeb, :view

  @doc """
  Traverses and translates changeset errors.

  See `Ecto.Changeset.traverse_errors/2` and
  `ContractsWeb.ErrorHelpers.translate_error/1` for more details.
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    # { _field, { message, _constraint }} = List.first(changeset.errors)
    # %{ error: message }
    %{errors: translate_errors(changeset)}
  end
end

defmodule ContractsWeb.Api.V1.PartView do
  use ContractsWeb, :view
  alias ContractsWeb.Api.V1.PartView

  def render("index.json", %{parts: parts}) do
    %{data: render_many(parts, PartView, "part.json")}
  end

  def render("show.json", %{part: part}) do
    %{data: render_one(part, PartView, "part.json")}
  end

  def render("part.json", %{part: part}) do
    %{id: part.id,
      name: part.name,
      surname: part.surname,
      email: part.email,
      tax_id: part.tax_id,
      telephone: part.telephone}
  end
end

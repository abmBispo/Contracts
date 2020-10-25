defmodule ContractsWeb.Api.V1.PartView do
  use ContractsWeb, :view
  alias ContractsWeb.Api.V1.PartView

  def render("index.json", %{parts: parts}) do
    %{
      pagination: %{
        total: parts.total_entries,
        current: parts.page_number
      },
      data: render_many(parts, PartView, "part.json")
    }
  end

  def render("show.json", %{part: part}) do
    %{data: render_one(part, PartView, "part.json")}
  end

  def render("part.json", %{part: part}) do
    %{
      id: part.id,
      email: part.email,
      name: part.profile.name,
      tax_id: part.profile.tax_id,
      telephone: part.profile.telephone
    }
  end
end

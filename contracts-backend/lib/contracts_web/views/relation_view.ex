defmodule ContractsWeb.RelationView do
  use ContractsWeb, :view
  alias ContractsWeb.RelationView

  def render("index.json", %{agreement_relations: agreement_relations}) do
    %{data: render_many(agreement_relations, RelationView, "relation.json")}
  end

  def render("show.json", %{relation: relation}) do
    %{data: render_one(relation, RelationView, "relation.json")}
  end

  def render("relation.json", %{relation: relation}) do
    %{id: relation.id}
  end
end

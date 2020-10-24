defmodule ContractsWeb.Api.V1.RelationView do
  use ContractsWeb, :view
  alias ContractsWeb.Api.V1.{
    RelationView,
    PartView,
    ContractView
  }

  def render("index.json", %{agreement_relations: agreement_relations}) do
    %{data: render_many(agreement_relations, RelationView, "relation.json")}
  end

  def render("show.json", %{relation: relation}) do
    %{data: render_one(relation, RelationView, "relation.json")}
  end

  def render("relation.json", %{relation: relation}) do
    %{id: relation.id}
  end

  def render("parts.json", %{parts: parts}) do
    %{data: render_many(parts, PartView, "part.json")}
  end

  def render("contracts.json", %{contracts: contracts}) do
    %{data: render_many(contracts, ContractView, "contract.json")}
  end
end

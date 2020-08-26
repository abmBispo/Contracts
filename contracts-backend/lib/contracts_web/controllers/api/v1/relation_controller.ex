defmodule ContractsWeb.Api.V1.RelationController do
  use ContractsWeb, :controller

  alias Contracts.Agreements
  alias Contracts.Agreements.Relation

  action_fallback ContractsWeb.FallbackController

  def index(conn, _params) do
    agreement_relations = Agreements.list_agreement_relations()
    render(conn, "index.json", agreement_relations: agreement_relations)
  end

  def create(conn, %{"relation" => relation_params}) do
    with {:ok, %Relation{} = relation} <- Agreements.create_relation(relation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.relation_path(conn, :show, relation))
      |> render("show.json", relation: relation)
    end
  end

  def show(conn, %{"id" => id}) do
    relation = Agreements.get_relation!(id)
    render(conn, "show.json", relation: relation)
  end

  def update(conn, %{"id" => id, "relation" => relation_params}) do
    relation = Agreements.get_relation!(id)

    with {:ok, %Relation{} = relation} <- Agreements.update_relation(relation, relation_params) do
      render(conn, "show.json", relation: relation)
    end
  end

  def delete(conn, %{"id" => id}) do
    relation = Agreements.get_relation!(id)

    with {:ok, %Relation{}} <- Agreements.delete_relation(relation) do
      send_resp(conn, :no_content, "")
    end
  end
end

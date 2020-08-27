defmodule ContractsWeb.Api.V1.RelationController do
  use ContractsWeb, :controller

  alias Contracts.Agreements
  alias Contracts.Agreements.Relation
  alias ContractsWeb.Api.V1.PartView

  action_fallback ContractsWeb.FallbackController

  def create(conn, %{"relation" => relation_params}) do
    with {:ok, %Relation{} = relation} <- Agreements.create_relation(relation_params) do
      conn
      |> put_status(:created)
      |> send_resp(:no_content, "")
    end
  end

  def delete(conn, params) do
    with {:ok, %Relation{}} <- Agreements.delete_relation(params) do
      send_resp(conn, :no_content, "")
    end
  end

  def contract_parts(conn, %{ "contract_id" => contract_id }) do
    parts =
      Agreements.get_contract!(contract_id)
      |> Agreements.list_contract_parts()
    render(conn, "parts.json", parts: parts)
  end

  def part_contracts(conn, %{ "part_id" => part_id }) do
    contracts = Agreements.list_part_contracts(part_id)
    render(conn, "contracts.json", contracts: contracts)
  end
end

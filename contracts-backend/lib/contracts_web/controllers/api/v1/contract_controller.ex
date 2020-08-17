defmodule ContractsWeb.Api.V1.ContractController do
  use ContractsWeb, :controller

  alias Contracts.Agreements
  alias Contracts.Agreements.Contract

  action_fallback ContractsWeb.FallbackController

  def index(conn, _params) do
    contracts = Agreements.list_contracts()
    render(conn, "index.json", contracts: contracts)
  end

  def create(conn, %{"contract" => contract_params}) do
    with {:ok, %Contract{} = contract} <- Agreements.create_contract(contract_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.contract_path(conn, :show, contract))
      |> render("show.json", contract: contract)
    end
  end

  def show(conn, %{"id" => id}) do
    contract = Agreements.get_contract!(id)
    render(conn, "show.json", contract: contract)
  end

  def update(conn, %{"id" => id, "contract" => contract_params}) do
    contract = Agreements.get_contract!(id)

    with {:ok, %Contract{} = contract} <- Agreements.update_contract(contract, contract_params) do
      render(conn, "show.json", contract: contract)
    end
  end

  def delete(conn, %{"id" => id}) do
    contract = Agreements.get_contract!(id)

    with {:ok, %Contract{}} <- Agreements.delete_contract(contract) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule ContractsWeb.Api.V1.ContractView do
  use ContractsWeb, :view
  alias ContractsWeb.Api.V1.ContractView

  def render("index.json", %{contracts: contracts}) do
    %{
      pagination: %{
        total: contracts.total_entries,
        current: contracts.page_number
      },
      data: render_many(contracts, ContractView, "contract.json")
    }
  end

  def render("show.json", %{contract: contract}) do
    %{data: render_one(contract, ContractView, "contract.json")}
  end

  def render("contract.json", %{contract: contract}) do
    %{
      id: contract.id,
      title: contract.title,
      begin: contract.begin,
      end: contract.end
    }
  end
end

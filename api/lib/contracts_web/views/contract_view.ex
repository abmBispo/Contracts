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
      begin: locale_date(:pt_br, contract.begin),
      end: locale_date(:pt_br, contract.end),
      file: %{
        file_name: contract.file.file_name,
        file_path: contract.file.file_name
      }
    }
  end

  defp locale_date(:pt_br, date) do
    [date.day, date.month, date.year]
      |> Enum.map(&to_string/1)
      |> Enum.map(&String.pad_leading(&1, 2, "0"))
      |> Enum.join("/")
  end
end

defmodule ContractsWeb.Api.V1.PartController do
  use ContractsWeb, :controller

  alias Contracts.Agreements
  alias Contracts.Agreements.Part

  action_fallback ContractsWeb.FallbackController

  def index(conn, _params) do
    parts = Agreements.list_parts()
    render(conn, "index.json", parts: parts)
  end

  def create(conn, %{"part" => part_params}) do
    with {:ok, %Part{} = part} <- Agreements.create_part(part_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.part_path(conn, :show, part))
      |> render("show.json", part: part)
    end
  end

  def show(conn, %{"id" => id}) do
    part = Agreements.get_part!(id)
    render(conn, "show.json", part: part)
  end

  def update(conn, %{"id" => id, "part" => part_params}) do
    part = Agreements.get_part!(id)

    with {:ok, %Part{} = part} <- Agreements.update_part(part, part_params) do
      render(conn, "show.json", part: part)
    end
  end

  def delete(conn, %{"id" => id}) do
    part = Agreements.get_part!(id)

    with {:ok, %Part{}} <- Agreements.delete_part(part) do
      send_resp(conn, :no_content, "")
    end
  end
end

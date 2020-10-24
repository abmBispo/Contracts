defmodule ContractsWeb.ContractControllerTest do
  use ContractsWeb.ConnCase

  alias Contracts.Agreements
  alias Contracts.Agreements.Contract

  @create_attrs %{
    begin: ~D[2010-04-17],
    end: ~D[2010-04-17],
    title: "some title"
  }
  @update_attrs %{
    begin: ~D[2011-05-18],
    end: ~D[2011-05-18],
    title: "some updated title"
  }
  @invalid_attrs %{begin: nil, end: nil, title: nil}

  def fixture(:contract) do
    {:ok, contract} = Agreements.create_contract(@create_attrs)
    contract
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contracts", %{conn: conn} do
      conn = get(conn, Routes.contract_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contract" do
    test "renders contract when data is valid", %{conn: conn} do
      conn = post(conn, Routes.contract_path(conn, :create), contract: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.contract_path(conn, :show, id))

      assert %{
               "id" => id,
               "begin" => "2010-04-17",
               "end" => "2010-04-17",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.contract_path(conn, :create), contract: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update contract" do
    setup [:create_contract]

    test "renders contract when data is valid", %{conn: conn, contract: %Contract{id: id} = contract} do
      conn = put(conn, Routes.contract_path(conn, :update, contract), contract: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.contract_path(conn, :show, id))

      assert %{
               "id" => id,
               "begin" => "2011-05-18",
               "end" => "2011-05-18",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, contract: contract} do
      conn = put(conn, Routes.contract_path(conn, :update, contract), contract: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete contract" do
    setup [:create_contract]

    test "deletes chosen contract", %{conn: conn, contract: contract} do
      conn = delete(conn, Routes.contract_path(conn, :delete, contract))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.contract_path(conn, :show, contract))
      end
    end
  end

  defp create_contract(_) do
    contract = fixture(:contract)
    %{contract: contract}
  end
end

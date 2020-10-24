defmodule ContractsWeb.PartControllerTest do
  use ContractsWeb.ConnCase

  alias Contracts.Agreements
  alias Contracts.Agreements.Part

  @create_attrs %{
    email: "some email",
    name: "some name",
    surname: "some surname",
    tax_id: "some tax_id",
    telephone: "some telephone"
  }
  @update_attrs %{
    email: "some updated email",
    name: "some updated name",
    surname: "some updated surname",
    tax_id: "some updated tax_id",
    telephone: "some updated telephone"
  }
  @invalid_attrs %{email: nil, name: nil, surname: nil, tax_id: nil, telephone: nil}

  def fixture(:part) do
    {:ok, part} = Agreements.create_part(@create_attrs)
    part
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all parts", %{conn: conn} do
      conn = get(conn, Routes.part_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create part" do
    test "renders part when data is valid", %{conn: conn} do
      conn = post(conn, Routes.part_path(conn, :create), part: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.part_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "name" => "some name",
               "surname" => "some surname",
               "tax_id" => "some tax_id",
               "telephone" => "some telephone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.part_path(conn, :create), part: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update part" do
    setup [:create_part]

    test "renders part when data is valid", %{conn: conn, part: %Part{id: id} = part} do
      conn = put(conn, Routes.part_path(conn, :update, part), part: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.part_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "name" => "some updated name",
               "surname" => "some updated surname",
               "tax_id" => "some updated tax_id",
               "telephone" => "some updated telephone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, part: part} do
      conn = put(conn, Routes.part_path(conn, :update, part), part: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete part" do
    setup [:create_part]

    test "deletes chosen part", %{conn: conn, part: part} do
      conn = delete(conn, Routes.part_path(conn, :delete, part))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.part_path(conn, :show, part))
      end
    end
  end

  defp create_part(_) do
    part = fixture(:part)
    %{part: part}
  end
end

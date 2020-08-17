defmodule Contracts.AgreementsTest do
  use Contracts.DataCase

  alias Contracts.Agreements

  describe "contracts" do
    alias Contracts.Agreements.Contract

    @valid_attrs %{begin: ~D[2010-04-17], end: ~D[2010-04-17], title: "some title"}
    @update_attrs %{begin: ~D[2011-05-18], end: ~D[2011-05-18], title: "some updated title"}
    @invalid_attrs %{begin: nil, end: nil, title: nil}

    def contract_fixture(attrs \\ %{}) do
      {:ok, contract} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Agreements.create_contract()

      contract
    end

    test "list_contracts/0 returns all contracts" do
      contract = contract_fixture()
      assert Agreements.list_contracts() == [contract]
    end

    test "get_contract!/1 returns the contract with given id" do
      contract = contract_fixture()
      assert Agreements.get_contract!(contract.id) == contract
    end

    test "create_contract/1 with valid data creates a contract" do
      assert {:ok, %Contract{} = contract} = Agreements.create_contract(@valid_attrs)
      assert contract.begin == ~D[2010-04-17]
      assert contract.end == ~D[2010-04-17]
      assert contract.title == "some title"
    end

    test "create_contract/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agreements.create_contract(@invalid_attrs)
    end

    test "update_contract/2 with valid data updates the contract" do
      contract = contract_fixture()
      assert {:ok, %Contract{} = contract} = Agreements.update_contract(contract, @update_attrs)
      assert contract.begin == ~D[2011-05-18]
      assert contract.end == ~D[2011-05-18]
      assert contract.title == "some updated title"
    end

    test "update_contract/2 with invalid data returns error changeset" do
      contract = contract_fixture()
      assert {:error, %Ecto.Changeset{}} = Agreements.update_contract(contract, @invalid_attrs)
      assert contract == Agreements.get_contract!(contract.id)
    end

    test "delete_contract/1 deletes the contract" do
      contract = contract_fixture()
      assert {:ok, %Contract{}} = Agreements.delete_contract(contract)
      assert_raise Ecto.NoResultsError, fn -> Agreements.get_contract!(contract.id) end
    end

    test "change_contract/1 returns a contract changeset" do
      contract = contract_fixture()
      assert %Ecto.Changeset{} = Agreements.change_contract(contract)
    end
  end
end

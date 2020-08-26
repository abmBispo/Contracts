defmodule Contracts.AgreementsTest do
  use Contracts.DataCase

  alias Contracts.Agreements

  describe "contracts" do
    alias Contracts.Agreements.Contract

    @contracts_valid_attrs %{begin: ~D[2010-04-17], end: ~D[2010-04-17], title: "some title"}
    @contracts_update_attrs %{begin: ~D[2011-05-18], end: ~D[2011-05-18], title: "some updated title"}
    @contracts_invalid_attrs %{begin: nil, end: nil, title: nil}

    @parts_valid_attrs %{email: "some email", name: "some name", surname: "some surname", tax_id: "some tax_id", telephone: "some telephone"}
    @parts_update_attrs %{email: "some updated email", name: "some updated name", surname: "some updated surname", tax_id: "some updated tax_id", telephone: "some updated telephone"}
    @parts_invalid_attrs %{email: nil, name: nil, surname: nil, tax_id: nil, telephone: nil}

    def contract_fixture(attrs \\ %{}) do
      {:ok, contract} =
        attrs
        |> Enum.into(@contracts_valid_attrs)
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
      assert {:ok, %Contract{} = contract} = Agreements.create_contract(@contracts_valid_attrs)
      assert contract.begin == ~D[2010-04-17]
      assert contract.end == ~D[2010-04-17]
      assert contract.title == "some title"
    end

    test "create_contract/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agreements.create_contract(@contracts_invalid_attrs)
    end

    test "update_contract/2 with valid data updates the contract" do
      contract = contract_fixture()
      assert {:ok, %Contract{} = contract} = Agreements.update_contract(contract, @contracts_update_attrs)
      assert contract.begin == ~D[2011-05-18]
      assert contract.end == ~D[2011-05-18]
      assert contract.title == "some updated title"
    end

    test "update_contract/2 with invalid data returns error changeset" do
      contract = contract_fixture()
      assert {:error, %Ecto.Changeset{}} = Agreements.update_contract(contract, @contracts_invalid_attrs)
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

  describe "parts" do
    alias Contracts.Agreements.Part

    def part_fixture(attrs \\ %{}) do
      {:ok, part} =
        attrs
        |> Enum.into(@parts_valid_attrs)
        |> Agreements.create_part()
      part
    end

    test "list_parts/0 returns all parts" do
      part = part_fixture()
      assert Agreements.list_parts() == [part]
    end

    test "get_part!/1 returns the part with given id" do
      part = part_fixture()
      assert Agreements.get_part!(part.id) == part
    end

    test "create_part/1 with valid data creates a part" do
      assert {:ok, part} = Agreements.create_part(@parts_valid_attrs)
      assert part.email == "some email"
      assert part.name == "some name"
      assert part.surname == "some surname"
      assert part.tax_id == "some tax_id"
      assert part.telephone == "some telephone"
    end

    test "create_part/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agreements.create_part(@parts_invalid_attrs)
    end

    test "update_part/2 with valid data updates the part" do
      part = part_fixture()
      assert {:ok, updated_part} = Agreements.update_part(part, @parts_update_attrs)

      assert updated_part.email == "some updated email"
      assert updated_part.name == "some updated name"
      assert updated_part.surname == "some updated surname"
      assert updated_part.tax_id == "some updated tax_id"
      assert updated_part.telephone == "some updated telephone"
    end

    test "update_part/2 with invalid data returns error changeset" do
      part = part_fixture()
      assert {:error, %Ecto.Changeset{}} = Agreements.update_part(part, @parts_invalid_attrs)
      assert part == Agreements.get_part!(part.id)
    end

    test "delete_part/1 deletes the part" do
      part = part_fixture()
      assert {:ok, %Part{}} = Agreements.delete_part(part)
      assert_raise Ecto.NoResultsError, fn -> Agreements.get_part!(part.id) end
    end

    test "change_part/1 returns a part changeset" do
      part = part_fixture()
      assert %Ecto.Changeset{} = Agreements.change_part(part)
    end
  end

  describe "agreement_relations" do
    alias Contracts.Agreements.Relation

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def relation_fixture(attrs \\ %{}) do
      {:ok, relation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Agreements.create_relation()

      relation
    end

    test "list_agreement_relations/0 returns all agreement_relations" do
      relation = relation_fixture()
      assert Agreements.list_agreement_relations() == [relation]
    end

    test "get_relation!/1 returns the relation with given id" do
      relation = relation_fixture()
      assert Agreements.get_relation!(relation.id) == relation
    end

    test "create_relation/1 with valid data creates a relation" do
      assert {:ok, %Relation{} = relation} = Agreements.create_relation(@valid_attrs)
    end

    test "create_relation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agreements.create_relation(@invalid_attrs)
    end

    test "update_relation/2 with valid data updates the relation" do
      relation = relation_fixture()
      assert {:ok, %Relation{} = relation} = Agreements.update_relation(relation, @update_attrs)
    end

    test "update_relation/2 with invalid data returns error changeset" do
      relation = relation_fixture()
      assert {:error, %Ecto.Changeset{}} = Agreements.update_relation(relation, @invalid_attrs)
      assert relation == Agreements.get_relation!(relation.id)
    end

    test "delete_relation/1 deletes the relation" do
      relation = relation_fixture()
      assert {:ok, %Relation{}} = Agreements.delete_relation(relation)
      assert_raise Ecto.NoResultsError, fn -> Agreements.get_relation!(relation.id) end
    end

    test "change_relation/1 returns a relation changeset" do
      relation = relation_fixture()
      assert %Ecto.Changeset{} = Agreements.change_relation(relation)
    end
  end
end

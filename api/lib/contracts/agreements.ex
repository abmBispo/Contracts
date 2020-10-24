defmodule Contracts.Agreements do
  @moduledoc """
  The Agreements context.
  """

  import Ecto.Query, warn: false
  alias Contracts.Repo

  alias Contracts.Agreements.Contract

  @doc """
  Returns the list of contracts.

  ## Examples

      iex> list_contracts()
      [%Contract{}, ...]

  """
  def list_contracts(%{"page" => page}), do: Repo.paginate(Contract, page: page)

  @doc """
  Gets a single contract.

  Raises `Ecto.NoResultsError` if the Contract does not exist.

  ## Examples

      iex> get_contract!(123)
      %Contract{}

      iex> get_contract!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contract!(id), do: Repo.get!(Contract, id)

  @doc """
  Creates a contract.

  ## Examples

      iex> create_contract(%{field: value})
      {:ok, %Contract{}}

      iex> create_contract(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contract(attrs \\ %{}) do
    %Contract{}
    |> Contract.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contract.

  ## Examples

      iex> update_contract(contract, %{field: new_value})
      {:ok, %Contract{}}

      iex> update_contract(contract, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contract(%Contract{} = contract, attrs) do
    contract
    |> Contract.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contract.

  ## Examples

      iex> delete_contract(contract)
      {:ok, %Contract{}}

      iex> delete_contract(contract)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contract(%Contract{} = contract) do
    Repo.delete(contract)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contract changes.

  ## Examples

      iex> change_contract(contract)
      %Ecto.Changeset{data: %Contract{}}

  """
  def change_contract(%Contract{} = contract, attrs \\ %{}) do
    Contract.changeset(contract, attrs)
  end

  alias Contracts.Agreements.Part

  @doc """
  Returns the list of parts.

  ## Examples

      iex> list_parts()
      [%Part{}, ...]

  """
  def list_parts(%{"page" => page}), do: Repo.paginate(Part, page: page)

  def list_parts(%{"query_search" => query_search}) do
    wildcard = "%#{query_search}%"

    query =
      from part in Part,
        where: like(part.email, ^wildcard) or like(part.tax_id, ^wildcard),
        select: part

    Repo.paginate(query, page: 1)
  end

  @doc """
  Gets a single part.

  Raises `Ecto.NoResultsError` if the Part does not exist.

  ## Examples

      iex> get_part!(123)
      %Part{}

      iex> get_part!(456)
      ** (Ecto.NoResultsError)

  """
  def get_part!(id), do: Repo.get!(Part, id)

  @doc """
  Creates a part.

  ## Examples

      iex> create_part(%{field: value})
      {:ok, %Part{}}

      iex> create_part(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_part(attrs \\ %{}) do
    registration =
      %Part.Registration{}
      |> Part.Registration.changeset(attrs)

    if registration.valid? do
      Repo.transaction(fn ->
        with {:ok, account} <- create_account(registration),
             {:ok, profile} <- create_profile(registration, account) do
          Part.Registration.mount_part(%{account: account, profile: profile})
        else
          {:error, error} ->
            Repo.rollback(error)
        end
      end)
    else
      registration = %{registration | action: :registration}
      {:error, registration}
    end
  end

  defp create_account(registration) do
    registration
    |> Part.Registration.to_account()
    |> Part.Account.changeset()
    |> Repo.insert()
  end

  defp create_profile(registration, account) do
    registration
    |> Part.Registration.to_profile()
    |> Part.Profile.changeset(%{account: account})
    |> Repo.insert()
  end

  @doc """
  Updates a part.

  ## Examples

      iex> update_part(part, %{field: new_value})
      {:ok, %Part{}}

      iex> update_part(part, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_part(%Part.Account{} = part, attrs) do
    part
    |> Part.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a part.

  ## Examples

      iex> delete_part(part)
      {:ok, %Part{}}

      iex> delete_part(part)
      {:error, %Ecto.Changeset{}}

  """
  def delete_part(%Part.Account{} = part) do
    Repo.delete(part)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking part changes.

  ## Examples

      iex> change_part(part)
      %Ecto.Changeset{data: %Part{}}

  """

  def change_part(%Part.Account{} = part, attrs \\ %{}) do
    Part.changeset(part, attrs)
  end

  alias Contracts.Agreements.Relation

  @doc """
  Returns the list of agreement_relations.

  ## Examples

      iex> list_agreement_relations()
      [%Relation{}, ...]

  """
  def list_contract_parts(%Contract{} = contract) do
    Ecto.assoc(contract, :parts)
    |> Repo.all()
  end

  @doc """
  Gets a single relation.

  Raises `Ecto.NoResultsError` if the Relation does not exist.

  ## Examples

      iex> get_relation!(123)
      %Relation{}

      iex> get_relation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_relation!(id), do: Repo.get!(Relation, id)

  @doc """
  Creates a relation.

  ## Examples

      iex> create_relation(%{field: value})
      {:ok, %Relation{}}

      iex> create_relation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_relation(attrs \\ %{}) do
    %Relation{}
    |> Relation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a relation.

  ## Examples

      iex> delete_relation(relation)
      {:ok, %Relation{}}

      iex> delete_relation(relation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_relation(%{"contract_id" => contract_id, "part_id" => part_id}) do
    query =
      from relation in Relation,
        where: relation.contract_id == ^contract_id and relation.part_id == ^part_id,
        select: relation

    {_, relations} = Repo.delete_all(query)
    {:ok, List.first(relations)}
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking relation changes.

  ## Examples

      iex> change_relation(relation)
      %Ecto.Changeset{data: %Relation{}}

  """
  def change_relation(%Relation{} = relation, attrs \\ %{}) do
    Relation.changeset(relation, attrs)
  end
end

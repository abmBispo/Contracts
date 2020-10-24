defmodule Contracts.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string, null: false
      add :password_digest, :string, null: false

      timestamps()
    end

    create index("accounts", [:email], unique: true)
  end
end

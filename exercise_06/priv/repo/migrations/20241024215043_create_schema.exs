defmodule Github.Repo.Migrations.CreateSchema do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :age, :integer
    end

    create unique_index(:users, [:first_name, :last_name])

    create table(:organizations) do
      add :name, :string, null: false
      add :description, :string
    end

    create unique_index(:organizations, :name)

    create table(:users_organizations, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :organization_id, references(:organizations, on_delete: :delete_all)
      timestamps()
    end

    create unique_index(:users_organizations, [:organization_id, :user_id])
  end
end

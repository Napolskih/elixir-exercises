defmodule Github.Organization do
  use Ecto.Schema

  schema "organizations" do
    field :name, :string
    field :description, :string

    many_to_many :users, Github.User, join_through: Github.UserOrganization
  end

  def changeset(organization, params \\ %{}) do
    organization
    |> Ecto.Changeset.cast(params, [:name, :description])
    |> Ecto.Changeset.validate_required([:name, :description])
  end
end

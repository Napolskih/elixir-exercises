defmodule Github.UserOrganization do
  use Ecto.Schema

  @primary_key false
  schema "users_organizations" do
    belongs_to :user, Github.User
    belongs_to :organization, Github.Organization
    timestamps()
  end
end

alias Github.{User, Organization, UserOrganization, Repo}

users = [
  %User{first_name: "Ryan", last_name: "Bigg", age: 28},
  %User{first_name: "John", last_name: "Smith", age: 27},
  %User{first_name: "Jane", last_name: "Smith", age: 26},
]

Enum.each(users, fn (user) -> Repo.insert!(user) end)


organizations = [
  %Organization{name: "Rosatom", description: "We bring warmth and light to your homes"},
  %Organization{name: "Kaspersky lab", description: "We develop antivirus software"}
]

Enum.each(organizations, fn (organization) -> Repo.insert!(organization) end)

%UserOrganization{
    user: Repo.get_by!(User, first_name: "Ryan"),
    organization: Organization |> Ecto.Query.first() |> Repo.one()
  }
  |> Repo.insert!()

  %UserOrganization{
    user: Repo.get_by!(User, first_name: "John"),
    organization: Organization |> Ecto.Query.first() |> Repo.one()
  }
  |> Repo.insert!()

  %UserOrganization{
    user: Repo.get_by!(User, first_name: "John"),
    organization: Organization |> Ecto.Query.last() |> Repo.one()
  }
  |> Repo.insert!()

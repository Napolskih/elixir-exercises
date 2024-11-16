defmodule GithubTest do
  use ExUnit.Case

  alias Github.{Organization, Repo, User, UserOrganization}

  test "the truth" do
    ryan = %User{first_name: "Ryan", last_name: "Bigg"} |> Repo.insert!()
    john = %User{first_name: "John", last_name: "Smith"} |> Repo.insert!()

    o = %Organization{name: "Rosatom"} |> Repo.insert!()

    %UserOrganization{user: ryan, organization: o} |> Repo.insert!()
    %UserOrganization{user: john, organization: o} |> Repo.insert!()

    assert Repo.aggregate(UserOrganization, :count) == 2

    ryan |> Repo.delete()

    assert Repo.aggregate(UserOrganization, :count) == 1

    john |> Repo.delete()

    assert Repo.aggregate(UserOrganization, :count) == 0
    assert Repo.aggregate(User, :count) == 0
  end
end

defmodule Github.Repo do
  use Ecto.Repo, otp_app: :Github, adapter: Ecto.Adapters.SQLite3
end

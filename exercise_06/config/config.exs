import Config

config :Github, Github.Repo,
  database: "database.db"

config :Github, ecto_repos: [Github.Repo]

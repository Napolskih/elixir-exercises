defmodule Github.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Github.Repo
      # Starts a worker by calling: Github.Worker.start_link(arg)
      # {Github.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Github.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

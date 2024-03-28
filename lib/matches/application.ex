defmodule Matches.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, args) do
    children = [
      # Starts a worker by calling: Matches.Worker.start_link(arg)
      # {Matches.Worker, arg}
      Matches.Repo,
      {Matches.DataFecherSupervisor, args}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Matches.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

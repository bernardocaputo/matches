defmodule Matches.DataFecherSupervisor do
  use Supervisor

  def start_link(providers) do
    Supervisor.start_link(__MODULE__, providers, name: __MODULE__)
  end

  def init(providers) do
    children = Enum.map(providers, &data_fetcher_child_spec/1)

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp data_fetcher_child_spec(provider) do
    %{start: {Matches.DataFecher, :start_link, [provider]}, id: provider}
  end
end

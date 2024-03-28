defmodule Matches.DataFecher do
  @moduledoc """
  This module is responsible to initialize the data fetcher that will fetch
  data from provider every 30 seconds and handle it to Matches.process/1
  """

  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(provider) do
    send(self(), :fetch_data)
    :timer.sleep(sleep())
    {:ok, provider}
  end

  @doc """
  fetch data from provider every 30 seconds
  """
  def handle_info(:fetch_data, provider) do
    Matches.process(provider)
    Process.send_after(self(), :fetch_data, 30_000)
    {:noreply, provider}
  end

  defp sleep() do
    Application.get_env(:matches, :sleep, 15_000)
  end
end

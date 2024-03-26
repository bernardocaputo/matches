defmodule Matches.DataFecher do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init({_provider, sleep} = args) do
    :timer.sleep(sleep)
    send(self(), :fetch_data)
    {:ok, args}
  end

  def handle_info(:fetch_data, {provider, _sleep} = current_state) do
    provider.process()
    Process.send_after(self(), :fetch_data, 3000)
    {:noreply, current_state}
  end
end

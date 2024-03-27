defmodule Matches do
  alias Matches.MatchesSchema

  @type provider :: atom()
  @moduledoc """
  Documentation for `Matches`.
  """
  @spec process(provider()) :: :ok | {:error, atom()}
  def process(provider) do
    with {:ok, data} <- provider.fetch_data(),
         prepared_data <- provider.prepare_data(data),
         {_, nil} <- MatchesSchema.insert_all(prepared_data) do
      :ok
    end
  end
end

defmodule Matches do
  alias Matches.MatchesSchema

  @moduledoc """
  Documentation for `Matches`.
  """
  @spec process(module()) :: :ok | {:error, atom()}
  def process(provider) do
    with {:ok, data} <- provider.fetch_data(),
         prepared_data <- provider.prepare_data(data),
         {_, nil} <- MatchesSchema.insert_all(prepared_data) do
      :ok
    end
  end
end

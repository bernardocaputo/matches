defmodule Matches.Providers.ProviderBehaviour do
  @moduledoc """
  Behaviour for all providers that may be part of the application
  """
  alias Matches.MatchesSchema

  @callback fetch_data() :: {:ok, [map()]} | {:error, atom()}
  @callback prepare_data(arg :: list(map)) :: [MatchesSchema.t()]
end

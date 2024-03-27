defmodule Matches.Providers.Behaviour do
  alias Matches.MatchesSchema

  @callback fetch_data() :: {:ok, [map()]} | {:error, atom()}
  @callback prepare_data(arg :: list(map)) :: [MatchesSchema.t()]
end

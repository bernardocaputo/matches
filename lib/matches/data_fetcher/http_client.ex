defmodule Matches.DataFetcher.HttpClientBehaviour do
  @callback get(arg :: binary()) :: {:ok, [map()]} | {:error, atom()}
end

defmodule Matches.DataFecher.HttpClient do
  @behaviour Matches.DataFetcher.HttpClientBehaviour
  require Logger

  @spec get(binary()) :: {:ok, [map()]} | {:error, atom()}
  def get(endpoint) do
    with {:ok, %{status_code: 200, body: body}} <- HTTPoison.get(endpoint),
         {:ok, %{"matches" => result}} <- Jason.decode(body) do
      {:ok, result}
    else
      {:ok, %{status_code: status, body: body}} ->
        Logger.info(%{status_code: status, body: body})
        {:error, status_code(status)}

      error ->
        Logger.error(inspect(error))
        {:error, :unexpected_error}
    end
  end

  defp status_code(400), do: :bad_request
  defp status_code(503), do: :service_unavailable
  defp status_code(_unexpected_error), do: :unexpected_error
end

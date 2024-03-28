for app <- Application.spec(:matches, :applications) do
  Application.ensure_all_started(app)
end

Mox.defmock(HttpClientMock, for: Matches.DataFetcher.HttpClientBehaviour)

ExUnit.start()

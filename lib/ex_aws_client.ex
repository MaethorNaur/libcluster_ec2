defmodule ClusterEC2.ExAwsFinch do
  @behaviour ExAws.Request.HttpClient
  def request(method, url, body \\ "", headers \\ [], http_opts \\ []) do
    case Finch.build(method, url, headers, body) |> Finch.request(ClusterEC2) do
      {:ok, %Finch.Response{status: status, headers: headers, body: body}} ->
        {:ok, %{status_code: status, headers: headers, body: body}}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end
end

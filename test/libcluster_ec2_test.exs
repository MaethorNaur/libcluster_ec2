defmodule ClusterEC2Test do
  use ExUnit.Case
  import Mock
  doctest ClusterEC2

  setup_with_mocks [
    {Finch, [:passthrough],
     request: fn
       %{host: "169.254.169.254", path: "/latest/meta-data/instance-id/"}, _ ->
         {:ok, %Finch.Response{status: 200, body: "i-0fdde7ca9faef9751"}}

       %{host: "169.254.169.254", path: "/latest/meta-data/placement/availability-zone/"}, _ ->
         {:ok, %Finch.Response{status: 200, body: "eu-central-1b"}}
     end}
  ] do
    :ok
  end


  test "return local_instance_id" do
    assert "i-0fdde7ca9faef9751" == ClusterEC2.local_instance_id()
  end

  test "return instance_region" do
    assert "eu-central-1" == ClusterEC2.instance_region()
  end
end

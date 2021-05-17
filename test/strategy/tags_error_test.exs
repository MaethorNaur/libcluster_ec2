defmodule Strategy.TagsErrorTest do
  use ExUnit.Case, async: false
  doctest ClusterEC2

  import Mock

  setup_with_mocks [
    {Finch, [:passthrough],
     request: fn
       %{host: "169.254.169.254", path: "/latest/meta-data/instance-id/"}, _ ->
         {:ok, %Finch.Response{status: 200, body: ""}}

       %{host: "169.254.169.254", path: "/latest/meta-data/placement/availability-zone/"}, _ ->
         {:ok, %Finch.Response{status: 200, body: ""}}
     end}
  ] do
    ops = [%Cluster.Strategy.State{
      topology: ClusterEC2.Strategy.Tags,
      connect: {:net_kernel, :connect, []},
      disconnect: {:net_kernel, :disconnect, []},
      list_nodes: {:erlang, :nodes, [:connected]},
      config: [
        ec2_tagname: "elasticbeanstalk:environment-name"
      ]
    }]

    {:ok, server_pid} = ClusterEC2.Strategy.Tags.start_link(ops)
    {:ok, server: server_pid}
  end

  test "test info call :load", %{server: pid} do
    assert :load == send(pid, :load)

    assert %Cluster.Strategy.State{
             config: [ec2_tagname: "elasticbeanstalk:environment-name"],
             connect: {:net_kernel, :connect, []},
             disconnect: {:net_kernel, :disconnect, []},
             list_nodes: {:erlang, :nodes, [:connected]},
             meta: MapSet.new([]),
             topology: ClusterEC2.Strategy.Tags
           } == :sys.get_state(pid)
  end
end

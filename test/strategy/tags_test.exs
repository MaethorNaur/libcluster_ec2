defmodule Strategy.TagsTest do
  use ExUnit.Case, async: false
  doctest ClusterEC2

  import Mock

  setup_with_mocks [
    {Finch, [:passthrough],
     request: fn
       %{host: "169.254.169.254", path: "/latest/meta-data/instance-id/"}, _ ->
         {:ok, %Finch.Response{status: 200, body: "i-0fdde7ca9faef9751"}}

       %{host: "169.254.169.254", path: "/latest/meta-data/placement/availability-zone/"}, _ ->
         {:ok, %Finch.Response{status: 200, body: "eu-central-1b"}}

       %{host: "ec2.eu-central-1.amazonaws.com", path: "/"}, _ ->
         {:ok,
          %Finch.Response{
            status: 200,
            body: """
            <DescribeInstancesResponse xmlns="http://ec2.amazonaws.com/doc/2016-11-15/">
                <requestId>8f7724cf-496f-496e-8fe3-example</requestId>
                <reservationSet>
                    <item>
                        <reservationId>r-1234567890abcdef0</reservationId>
                        <ownerId>123456789012</ownerId>
                        <groupSet/>
                        <instancesSet>
                            <item>
                                <instanceId>i-1234567890abcdef0</instanceId>
                                <imageId>ami-bff32ccc</imageId>
                                <instanceState>
                                    <code>16</code>
                                    <name>running</name>
                                </instanceState>
                                <privateDnsName>ip-192-168-1-88.eu-west-1.compute.internal</privateDnsName>
                                <dnsName>ec2-54-194-252-215.eu-west-1.compute.amazonaws.com</dnsName>
                                <reason/>
                                <keyName>my_keypair</keyName>
                                <amiLaunchIndex>0</amiLaunchIndex>
                                <productCodes/>
                                <instanceType>t2.micro</instanceType>
                                <launchTime>2018-05-08T16:46:19.000Z</launchTime>
                                <placement>
                                    <availabilityZone>eu-west-1c</availabilityZone>
                                    <groupName/>
                                    <tenancy>default</tenancy>
                                </placement>
                                <monitoring>
                                    <state>disabled</state>
                                </monitoring>
                                <subnetId>subnet-56f5f633</subnetId>
                                <vpcId>vpc-11112222</vpcId>
                                <privateIpAddress>192.168.1.88</privateIpAddress>
                                <ipAddress>54.194.252.215</ipAddress>
                                <sourceDestCheck>true</sourceDestCheck>
                                <groupSet>
                                    <item>
                                        <groupId>sg-e4076980</groupId>
                                        <groupName>SecurityGroup1</groupName>
                                    </item>
                                </groupSet>
                                <architecture>x86_64</architecture>
                                <rootDeviceType>ebs</rootDeviceType>
                                <rootDeviceName>/dev/xvda</rootDeviceName>
                                <blockDeviceMapping>
                                    <item>
                                        <deviceName>/dev/xvda</deviceName>
                                        <ebs>
                                            <volumeId>vol-1234567890abcdef0</volumeId>
                                            <status>attached</status>
                                            <attachTime>2015-12-22T10:44:09.000Z</attachTime>
                                            <deleteOnTermination>true</deleteOnTermination>
                                        </ebs>
                                    </item>
                                </blockDeviceMapping>
                                <virtualizationType>hvm</virtualizationType>
                                <clientToken>xMcwG14507example</clientToken>
                                <tagSet>
                                    <item>
                                        <key>Name</key>
                                        <value>Server_1</value>
                                    </item>
                                </tagSet>
                                <hypervisor>xen</hypervisor>
                                <networkInterfaceSet>
                                    <item>
                                        <networkInterfaceId>eni-551ba033</networkInterfaceId>
                                        <subnetId>subnet-56f5f633</subnetId>
                                        <vpcId>vpc-11112222</vpcId>
                                        <description>Primary network interface</description>
                                        <ownerId>123456789012</ownerId>
                                        <status>in-use</status>
                                        <macAddress>02:dd:2c:5e:01:69</macAddress>
                                        <privateIpAddress>192.168.1.88</privateIpAddress>
                                        <privateDnsName>ip-192-168-1-88.eu-west-1.compute.internal</privateDnsName>
                                        <sourceDestCheck>true</sourceDestCheck>
                                        <groupSet>
                                            <item>
                                                <groupId>sg-e4076980</groupId>
                                                <groupName>SecurityGroup1</groupName>
                                            </item>
                                        </groupSet>
                                        <attachment>
                                            <attachmentId>eni-attach-39697adc</attachmentId>
                                            <deviceIndex>0</deviceIndex>
                                            <status>attached</status>
                                            <attachTime>2018-05-08T16:46:19.000Z</attachTime>
                                            <deleteOnTermination>true</deleteOnTermination>
                                        </attachment>
                                        <association>
                                            <publicIp>54.194.252.215</publicIp>
                                            <publicDnsName>ec2-54-194-252-215.eu-west-1.compute.amazonaws.com</publicDnsName>
                                            <ipOwnerId>amazon</ipOwnerId>
                                        </association>
                                        <privateIpAddressesSet>
                                            <item>
                                                <privateIpAddress>192.168.1.88</privateIpAddress>
                                                <privateDnsName>ip-192-168-1-88.eu-west-1.compute.internal</privateDnsName>
                                                <primary>true</primary>
                                                <association>
                                                <publicIp>54.194.252.215</publicIp>
                                                <publicDnsName>ec2-54-194-252-215.eu-west-1.compute.amazonaws.com</publicDnsName>
                                                <ipOwnerId>amazon</ipOwnerId>
                                                </association>
                                            </item>
                                        </privateIpAddressesSet>
                                        <ipv6AddressesSet>
                                           <item>
                                               <ipv6Address>2001:db8:1234:1a2b::123</ipv6Address>
                                           </item>
                                       </ipv6AddressesSet>
                                    </item>
                                </networkInterfaceSet>
                                <iamInstanceProfile>
                                    <arn>arn:aws:iam::123456789012:instance-profile/AdminRole</arn>
                                    <id>ABCAJEDNCAA64SSD123AB</id>
                                </iamInstanceProfile>
                                <ebsOptimized>false</ebsOptimized>
                                <cpuOptions>
                                    <coreCount>1</coreCount>
                                    <threadsPerCore>1</threadsPerCore>
                                </cpuOptions>
                            </item>
                        </instancesSet>
                    </item>
                </reservationSet>
            </DescribeInstancesResponse>
            """
          }}
     end}
  ] do
    ops = [
      %Cluster.Strategy.State{
        topology: ClusterEC2.Strategy.Tags,
        connect: {:net_kernel, :connect_node, []},
        disconnect: {:net_kernel, :disconnect, []},
        list_nodes: {:erlang, :nodes, [:connected]},
        config: [
          ec2_tagname: "elasticbeanstalk:environment-name"
        ]
      }
    ]

    {:ok, server_pid} = ClusterEC2.Strategy.Tags.start_link(ops)
    {:ok, server: server_pid}
  end

  test "test info call :load", %{server: pid} do
    assert :load == send(pid, :load)

    assert %Cluster.Strategy.State{
             config: [ec2_tagname: "elasticbeanstalk:environment-name"],
             connect: {:net_kernel, :connect_node, []},
             disconnect: {:net_kernel, :disconnect, []},
             list_nodes: {:erlang, :nodes, [:connected]},
             meta: MapSet.new([]),
             topology: ClusterEC2.Strategy.Tags
           } == :sys.get_state(pid)
  end
end

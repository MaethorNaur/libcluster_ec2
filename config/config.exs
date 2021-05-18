# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :libcluster_ec2, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:libcluster_ec2, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :libcluster,
  topologies: [
    example: [
      strategy: ClusterEC2.Strategy.Tags,
      config: [
        ec2_tagname: System.get_env("EC2_TAGNAME"),
        ec2_tagvalue: System.get_env("EC2_TAGVALUE"),
        app_prefix: System.get_env("APP_PREFIX"),
        show_debug: false
      ]
    ]
  ]

config :ex_aws, http_client: ClusterEC2.ExAwsFinch

if Mix.env() == :test do
  config :ex_aws,
    access_key_id: "xxx",
    secret_access_key: "xxx"
end

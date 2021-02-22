use Mix.Config

gossip_config =
  if System.get_env("GOSSIP_AUTH") do
    [secret: System.get_env("GOSSIP_AUTH")]
  else
    []
  end

gossip_topology =
  [
    fumetsu_gossip: [
      strategy: Cluster.Strategy.Gossip,
      config: gossip_config,
    ]
  ]

config :fumetsu,
  topology: gossip_topology


config :logger, :console,
  format: "[$time] $metadata[$level]$levelpad $message\n",
  metadata: [:file, :line]

# Run Redpanda on Nomad

This is a development setup that stores data inside each container. Data will
be lost once you turn everything down.

All ports are dynamic, use Consul's UI to find them out.

### From MacOS
1. `nomad agent -dev -bind=0.0.0.0 -network-interface=en0`
1. `consul agent -dev -client=0.0.0.0 -bind=192.168.88.154`. Use the IP your
machine has in `en0`.
1. `nomad run redpanda.nomad`
1. Nomad's UI: http://127.0.0.1:4646/ui/jobs
1. Consul's UI: http://localhost:8500/ui/
1. Take note of the port for the Admin service, and from your MacOS terminal, run:

```
❯ rpk cluster health --api-urls="192.168.88.154:20267"

CLUSTER HEALTH OVERVIEW
=======================
Healthy:                     true
Unhealthy reasons:           []
Controller ID:               0
All nodes:                   [0 1 2]
Nodes down:                  []
Leaderless partitions:       []
Under-replicated partitions: []
```

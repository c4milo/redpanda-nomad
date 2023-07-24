job "redpanda-cluster" {
  datacenters = ["dc1"]
  type        = "service"

  // Only roll 1 broker at a time. Tweak the stagger time based on
  // your particular case.
  update {
    stagger      = "30s"
    max_parallel = 1
  }

  group "node0" {
    count = 1

    network {
      mode = "host"
      port "rpc" {}
      port "kafka" {}
      port "admin" {}
      port "http_proxy" {}
      port "schema_registry" {}
    }

    service {
      name     = "rpc"
      port     = "rpc"
      provider = "consul"
    }

    service {
      name     = "kafka"
      port     = "kafka"
      provider = "consul"
    }

    service {
      name     = "admin"
      port     = "admin"
      provider = "consul"
    }

    service {
      name     = "http-proxy"
      port     = "http_proxy"
      provider = "consul"
    }

    service {
      name     = "schema-registry"
      port     = "schema_registry"
      provider = "consul"
    }

    task "redpanda" {
      driver = "docker"
      config {
        image = "vectorized/redpanda:latest"
        ports = ["kafka", "admin", "rpc", "http_proxy", "schema_registry"]
        args = [
          "redpanda", "start",
          "--node-id", "0",
          "--overprovisioned",
          "--smp=1", # has to match what's given in the resources block
          "--memory=1G", # has to match what's given in the resources block
          "--default-log-level=info",
          "--config", "local/redpanda.yml",
        ]
        // privileged = true # so rpk tuners can tune
      }

      artifact {
        source = "https://gist.githubusercontent.com/c4milo/15e35f49e34d84bc6e1918e02b70baab/raw/fa3ecc72acd31852989fb0a7f7bd02cf207c8ddb/redpanda.yml.tpl"
      }

      template {
        source      = "local/redpanda.yml.tpl"
        destination = "local/redpanda.yml"
        change_mode = "restart"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }
    }
  }

  # These groups below are an exact copy of the node0 group
  group "node1" {
    count = 1

    network {
      mode = "host"
      port "rpc" {}
      port "kafka" {}
      port "admin" {}
      port "http_proxy" {}
      port "schema_registry" {}
    }

    service {
      name     = "rpc"
      port     = "rpc"
      provider = "consul"
    }

    service {
      name     = "kafka"
      port     = "kafka"
      provider = "consul"
    }

    service {
      name     = "admin"
      port     = "admin"
      provider = "consul"
    }

    service {
      name     = "http-proxy"
      port     = "http_proxy"
      provider = "consul"
    }

    service {
      name     = "schema-registry"
      port     = "schema_registry"
      provider = "consul"
    }

    task "redpanda" {
      driver = "docker"
      config {
        image = "vectorized/redpanda:latest"
        ports = ["kafka", "admin", "rpc", "http_proxy", "schema_registry"]
        // command = "/usr/bin/rpk" # already done by Dockerfile
        args = [
          "redpanda", "start",
          "--node-id", "1",
          "--overprovisioned",
          "--smp=1",
          "--memory=1G",
          "--default-log-level=info",
          "--config", "local/redpanda.yml",
        ]
        // privileged = true # so rpk tuners can tune
      }

      artifact {
        source = "https://gist.githubusercontent.com/c4milo/15e35f49e34d84bc6e1918e02b70baab/raw/fa3ecc72acd31852989fb0a7f7bd02cf207c8ddb/redpanda.yml.tpl"
      }

      template {
        source      = "local/redpanda.yml.tpl"
        destination = "local/redpanda.yml"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }
    }
  }

  group "node2" {
    count = 1

    network {
      mode = "host"
      port "rpc" {}
      port "kafka" {}
      port "admin" {}
      port "http_proxy" {}
      port "schema_registry" {}
    }

    service {
      name     = "rpc"
      port     = "rpc"
      provider = "consul"
    }

    service {
      name     = "kafka"
      port     = "kafka"
      provider = "consul"
    }

    service {
      name     = "admin"
      port     = "admin"
      provider = "consul"
    }

    service {
      name     = "http-proxy"
      port     = "http_proxy"
      provider = "consul"
    }

    service {
      name     = "schema-registry"
      port     = "schema_registry"
      provider = "consul"
    }

    task "redpanda" {
      driver = "docker"
      config {
        image = "vectorized/redpanda:latest"
        ports = ["kafka", "admin", "rpc", "http_proxy", "schema_registry"]
        // command = "/usr/bin/rpk" # already done by Dockerfile
        args = [
          "redpanda", "start",
          "--node-id", "2",
          "--overprovisioned",
          "--smp=1",
          "--memory=1G",
          "--default-log-level=info",
          "--config", "local/redpanda.yml",
        ]
        // privileged = true # so rpk tuners can tune
      }

      artifact {
        source = "https://gist.githubusercontent.com/c4milo/15e35f49e34d84bc6e1918e02b70baab/raw/fa3ecc72acd31852989fb0a7f7bd02cf207c8ddb/redpanda.yml.tpl"
      }

      template {
        source      = "local/redpanda.yml.tpl"
        destination = "local/redpanda.yml"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }
    }
  }
}

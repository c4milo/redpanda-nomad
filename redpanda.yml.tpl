redpanda:
  developer_mode: true
  data_directory: /var/lib/redpanda/data
  rack: {{ env "node.datacenter" }}
  empty_seed_starts_cluster: false
  seed_servers:
   {{- range service "rpc" }}
    - host:
      address: {{ .Address }}
      port: {{ .Port }}
  {{- end }}
  rpc_server:
    address: 0.0.0.0
    port: {{ env "NOMAD_PORT_rpc" }}
  kafka_api:
    - address: 0.0.0.0
      port: {{ env "NOMAD_PORT_kafka" }}
      name: kafka
  admin:
    - address: 0.0.0.0
      port: {{env "NOMAD_PORT_admin" }}
      name: admin
  # cloud_storage_cache_directory: /var/lib/shadow-index-cache
  advertised_rpc_api:
    address: {{ env "NOMAD_IP_rpc" }}
    port: {{ env "NOMAD_PORT_rpc" }}
  advertised_kafka_api:
    - address: {{ env "NOMAD_IP_kafka" }}
      port: {{ env "NOMAD_PORT_kafka" }}
      name: kafka
  aggregate_metrics: true
  auto_create_topics_enabled: true
  # cloud_storage_access_key: unused
  # cloud_storage_api_endpoint: s3.us-east-2.amazonaws.com
  # cloud_storage_bucket: redpanda-cloud-storage-certnoj7m575jtvbg730
  # cloud_storage_cache_size: "375000000000"
  # cloud_storage_credentials_source: sts
  # cloud_storage_disable_tls: false
  # cloud_storage_enable_remote_read: true
  # cloud_storage_enable_remote_write: true
  # cloud_storage_enabled: true
  # cloud_storage_region: us-east-2
  # cloud_storage_secret_key: unused
  # cloud_storage_segment_max_upload_interval_sec: 3600
  # cloud_storage_trust_file: /etc/ssl/certs/ca-certificates.crt
  cluster_id: rp-certnoj7m575jtvbg732
  compacted_log_segment_size: 67108864
  default_topic_replications: 3
  enable_rack_awareness: false
  enable_usage: true
  group_topic_partitions: 16
  id_allocator_replication: 3
  internal_topic_replication_factor: 3
  kafka_batch_max_bytes: 1048576
  kafka_connection_rate_limit: 1000
  kafka_connections_max: 15100
  kafka_enable_authorization: true
  log_segment_size: 134217728
  log_segment_size_max: 268435456
  log_segment_size_min: 16777216
  max_compacted_log_segment_size: 536870912
  partition_autobalancing_mode: continuous
  superusers:
      - pandaproxy_client
      - schemaregistry_client
  topic_partitions_per_shard: 1000
  transaction_coordinator_replication: 3
rpk:
  tune_network: true
  tune_disk_scheduler: true
  tune_disk_nomerges: true
  tune_disk_write_cache: true
  tune_disk_irq: true
  tune_cpu: true
  tune_aio_events: true
  tune_clocksource: true
  tune_swappiness: true
  coredump_dir: /var/lib/redpanda/coredump
  tune_ballast_file: true

pandaproxy:
  pandaproxy_api:
    - address: 0.0.0.0
      port: {{ env "NOMAD_PORT_http_proxy" }}
      name: proxy
  advertised_pandaproxy_api:
    - address: {{ env "NOMAD_IP_http_proxy" }}
      port: {{ env "NOMAD_PORT_http_proxy" }}
      name: proxy
pandaproxy_client:
  brokers:
    {{- range service "http-proxy" }}
    - address: {{ .Address }}
      port: {{ .Port }}
    {{- end }}
schema_registry:
  schema_registry_api:
    - address: 0.0.0.0
      port: {{ env "NOMAD_PORT_schema_registry" }}
      name: schema-registry
schema_registry_client:
  brokers:
    {{- range service "schema-registry" }}
    - address: {{ .Address }}
      port: {{ .Port }}
    {{- end }}

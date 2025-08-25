# Suricata + ELK Repo

This repository boots a small Suricata IDS + Elastic (Elasticsearch, Kibana) stack and uses Filebeat to ship Suricata's JSON `eve.json` to Elasticsearch.

Setup
- Install Docker Desktop and enable WSL2 integration (or run on Linux).
- Ensure `./logs` and `./suricata` folders exist and are readable/writable by containers.
- Run the stack from a Linux shell (or WSL2) and generate test traffic.

Prerequisites
- Docker Desktop (with WSL2 integration) OR a Linux machine.

Quick start (WSL2 / Linux)

1. Open a WSL2 shell or a Linux terminal and change to the project:

```bash
cd /mnt/c/Users/User/Projects/Suricata-ELK-IDS-Starter
```

2. Start the stack:

```bash
docker-compose up -d
```

3. Generate test traffic:

```bash
chmod +x scripts/generate-test-traffic.sh
./scripts/generate-test-traffic.sh 127.0.0.1 http://127.0.0.1:80
```

What changed in this repo
- Suricata now writes structured JSON to `/var/log/suricata/eve.json`.
- Filebeat is added and configured at `filebeat/filebeat.yml` to read `eve.json` and send events to Elasticsearch.

Validation steps

- Tail the Suricata JSON file on the host:

```bash
tail -n 50 ./logs/eve.json
```

- Check Filebeat container logs (replace name with container shown by `docker ps`):

```bash
docker logs <filebeat_container_name> --tail 200
```

- Query Elasticsearch for recent Suricata documents:

```bash
curl -s 'http://localhost:9200/_search?q=service:suricata&pretty' | jq .
```

- Open Kibana at http://localhost:5601 and look in Discover for `filebeat-*` or `suricata-*` indices.

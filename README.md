
# Suricata + ELK IDS on *Linux

This project uses Docker to quickly run Suricata IDS with the ELK stack for live traffic analysis.

## Setup

```bash
git clone <repo>
cd Suricata-ELK-IDS
```

check active interface with
```bash
ip a | grep inet
```
update suricata.yaml with correct interface if needed
then run
```bash
docker-compose up
```

Access Kibana at `http://localhost:5601`.

## Simulate Traffic

```bash
chmod +x scripts/generate-test-traffic.sh
./scripts/generate-test-traffic.sh
```

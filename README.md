
# Suricata + ELK IDS on *Linux

This project uses Docker to quickly run Suricata IDS with the ELK stack for live traffic analysis.

## Setup

```bash
git clone https://github.com/BrianChaput/Suricata-ELK-Starter.git
cd Suricata-ELK-Starter
```

Check active interface with
```bash
ip a | grep inet
```
Update suricata.yaml with correct interface if needed
then run
```bash
docker-compose up
```

Access Kibana at `http://localhost:5601`.

Add rules to /rules/custom.rules
## Simulate Traffic

```bash
chmod +x scripts/generate-test-traffic.sh
./scripts/generate-test-traffic.sh
```

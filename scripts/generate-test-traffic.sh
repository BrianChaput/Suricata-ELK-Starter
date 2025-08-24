#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-127.0.0.1}"   # default target
HTTP_TARGET="${2:-http://$TARGET:80}"

echo "Target: $TARGET"
echo "HTTP target: $HTTP_TARGET"

# function to check command
require() {
  command -v "$1" >/dev/null 2>&1 || { echo "Missing $1, please install it."; exit 1; }
}

# Use hping3 if available, otherwise use ping
if command -v hping3 >/dev/null 2>&1; then
  echo "Sending ICMP via hping3..."
  hping3 --icmp -c 5 "$TARGET"
else
  echo "Sending ICMP via ping..."
  ping -c 5 "$TARGET"
fi

# suspicious HTTP user-agent
echo "Sending HTTP GET with suspicious User-Agent (curl)..."
curl -s -o /dev/null -A "curl/7.XX (suspicious)" "$HTTP_TARGET"

# Shellshock-style rule
echo "Sending suspicious Shellshock-like header..."
curl -s -o /dev/null -H 'User-Agent: () { :; }; /bin/bash -c "echo shellshock_test"' "$HTTP_TARGET"

# Download a fake .exe (a small text file)
echo "Requesting a .exe URI to trigger EXE-download rule..."
curl -s -o /dev/null "$HTTP_TARGET/somefile.exe"

# Trigger a potential remote shell keyword in URI
echo "Requesting URI that contains /bin/sh..."
curl -s -o /dev/null "$HTTP_TARGET/bin/sh"

echo "Done."
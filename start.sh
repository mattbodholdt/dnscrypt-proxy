#!/bin/bash -e
dnsmasq --no-daemon &
/go/linux-amd64/dnscrypt-proxy dnscrypt-proxy.toml

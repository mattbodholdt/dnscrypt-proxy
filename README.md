# DNSCrypt-Proxy

A DNS server container which consumes Cloudflare's DNS over HTTPS resolution service (https://developers.cloudflare.com/1.1.1.1/dns-over-https/, https://1.1.1.1) by utilizing DNSCrypt Proxy (https://github.com/jedisct1/dnscrypt-proxy, https://dnscrypt.info/).

In this config, tcp and udp port 53 must be free on the host:

```bash
docker run -dt --dns 127.0.0.1 -p 53:53/udp -p 53:53/tcp --name dnscrypt-proxy --restart unless-stopped mattbodholdt/dnscrypt-proxy
```

If you need it to listen on an alternate port:

```bash
docker run -dt --dns 127.0.0.1 -p 5353:53/udp -p 5353:53/tcp --name dnscrypt-proxy --restart unless-stopped mattbodholdt/dnscrypt-proxy
```

---------------
If you want to modify the server list being used or other parameters you can clone the repo, modify the configuration files, build your own image, and run from that build.

Clone Repo:
git clone https://github.com/mattbodholdt/dnscrypt-proxy.git

Modify DNSCrypt-Proxy config:
dnscrypt-proxy/dnscrypt-proxy.toml

Modify servers to meet your needs, adjust other params if desired.  For more detail around those settings, see: https://github.com/jedisct1/dnscrypt-proxy/wiki/Configuration-Sources

Modify dnscrypt-proxy/Dockerfile if you want to adjust the monitor

Run the build:
```bash
docker build -f dnscrypt-proxy/Dockerfile dnscrypt-proxy/ -t dnscrypt-proxy-build
```

Run a container from the build:
```bash
docker run -dt --dns 127.0.0.1 -p 53:53/udp -p 53:53/tcp --name dnscrypt-proxy --restart unless-stopped dnscrypt-proxy-build
```

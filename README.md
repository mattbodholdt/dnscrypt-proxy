# DNSCrypt-Proxy

Container that uses Cloudflare's DNS over HTTPS resolution service (https://developers.cloudflare.com/1.1.1.1/dns-over-https/, https://1.1.1.1) by utilizing DNSCrypt Proxy (https://github.com/jedisct1/dnscrypt-proxy, https://dnscrypt.info/).

In this config, tcp and udp port 53 must be free on the host:

docker run -dt --dns 127.0.0.1 -p 53:53/udp -p 53:53/tcp --name dnscrypt-proxy --restart unless-stopped mattbodholdt/dnscrypt-proxy

If you need it to listen on an alternate port:

docker run -dt --dns 127.0.0.1 -p 5353:53/udp -p 5353:53/tcp --name dnscrypt-proxy --restart unless-stopped mattbodholdt/dnscrypt-proxy

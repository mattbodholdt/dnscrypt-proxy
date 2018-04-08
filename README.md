# DNSCrypt-Proxy

docker run -dt --dns 127.0.0.1 -p 53:53/udp -p 53:53/tcp --name dnscrypt-proxy --restart unless-stopped mattbodholdt/dnscrypt-proxy

Container that uses Cloudflare's DNS over HTTPS resolution service (https://developers.cloudflare.com/1.1.1.1/dns-over-https/) by utilizing DNSCrypt Proxy (https://github.com/jedisct1/dnscrypt-proxy).

This container requires udp and tcp port 53 be free (by default).

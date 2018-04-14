FROM golang:latest

RUN apt update && apt install -y \
	dnsutils && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
ADD ./start.sh /etc/dnscrypt-proxy/start.sh

RUN  git clone https://github.com/jedisct1/dnscrypt-proxy src && \
        cd src/dnscrypt-proxy && \
        go get -d && \
        go clean && \
        go build -ldflags="-s -w" -o $GOPATH/linux-amd64/dnscrypt-proxy && \
	cd .. && \
	cp systemd/* $GOPATH/linux-amd64/ && \
	cd .. && \
	rm -rf ./src && \
	chmod +x /etc/dnscrypt-proxy/start.sh

WORKDIR "/etc/dnscrypt-proxy/"

CMD ["./start.sh"]

HEALTHCHECK CMD dig -x 1.1.1.1 || exit 1

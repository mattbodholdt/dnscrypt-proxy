FROM golang:latest

ADD ./dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml

RUN  git clone https://github.com/jedisct1/dnscrypt-proxy src && \
        cd src/dnscrypt-proxy && \
        go get -d && \
        go clean && \
        go build -ldflags="-s -w" -o $GOPATH/linux-amd64/dnscrypt-proxy && \
	cd .. && \
	cp systemd/* $GOPATH/linux-amd64/ && \
	cd .. && \
	rm -rf ./src
	
EXPOSE 53 53/udp
EXPOSE 53 53/tcp

WORKDIR "/etc/dnscrypt-proxy/"

CMD ["/go/linux-amd64/dnscrypt-proxy","dnscrypt-proxy.toml"]

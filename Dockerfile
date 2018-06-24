FROM golang:alpine

RUN apk add --update bind-tools \
		git && \
	apk upgrade && \
	rm -rf /var/cache/apk/*

ADD ./dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
ADD ./start.sh /etc/dnscrypt-proxy/start.sh

RUN  git clone https://github.com/jedisct1/dnscrypt-proxy src && \
        cd src/dnscrypt-proxy && \
        go get -d && \
        go clean && \
        go build -ldflags="-s -w" -o $GOPATH/linux-amd64/dnscrypt-proxy && \
	cd ../.. && \
	rm -rf ./src && \
	chmod +x /etc/dnscrypt-proxy/start.sh

WORKDIR "/etc/dnscrypt-proxy/"

CMD ["./start.sh"]

HEALTHCHECK CMD dig -x 1.1.1.1 || exit 1

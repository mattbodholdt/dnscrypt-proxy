FROM golang:alpine

RUN apk add --update bind-tools curl git && \
	sleep 5 && \
	rm -rf /var/cache/apk/*

ADD dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
ADD test.sh /etc/dnscrypt-proxy/test.sh

RUN curl --silent -L https://github.com/jedisct1/dnscrypt-proxy/releases/download/2.0.25/dnscrypt-proxy-linux_x86_64-2.0.25.tar.gz > dnscrypt-proxy-linux_x86_64.tar.gz && \
	tar -xzf dnscrypt-proxy-linux_x86_64.tar.gz && \
	mv linux-x86_64/dnscrypt-proxy $GOPATH/bin/dnscrypt-proxy && \
	rm -rf dnscrypt-proxy-linux_x86_64.tar.gz linux-x86_64

ENTRYPOINT ["/go/bin/dnscrypt-proxy", "-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml"]

HEALTHCHECK CMD dig one.one.one.one || exit 1

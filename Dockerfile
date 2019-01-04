FROM golang:alpine

RUN apk add --update bind-tools curl && \
	apk upgrade && \
	rm -rf /var/cache/apk/*

ADD ./dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
ADD ./start.sh /etc/dnscrypt-proxy/start.sh

RUN curl --silent -L https://github.com/jedisct1/dnscrypt-proxy/releases/download/2.0.19/dnscrypt-proxy-linux_x86_64-2.0.19.tar.gz > dnscrypt-proxy-linux_x86_64.tar.gz && \
	tar -xzf dnscrypt-proxy-linux_x86_64.tar.gz && \
        mv linux-x86_64/dnscrypt-proxy $GOPATH/dnscrypt-proxy && \
	chmod +x /etc/dnscrypt-proxy/start.sh

WORKDIR "/etc/dnscrypt-proxy/"

CMD ["./start.sh"]

HEALTHCHECK CMD dig -x 1.1.1.1 || exit 1

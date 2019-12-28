FROM golang:alpine

ARG VER=2.0.36

RUN apk add --update bind-tools curl && \
	rm -rf /var/cache/apk/*

ADD dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
ADD test.sh /etc/dnscrypt-proxy/test.sh

RUN case $(uname -m) in 				\
	armv7l)						\
		ARCH=arm				\
	;;						\
	arm64|aarch64)					\
		ARCH=arm64				\
	;;						\
	amd64|x86_64)					\
		ARCH=x86_64				\
	;;						\
	*)						\
		echo "Unhandled arch $(uname -m)!  Please report!" \
		ARCH=unknown				\
	;;						\
	esac;						\
	echo "Fetching dnscrypt-proxy-${VER} for ${ARCH}";	\
	curl --silent -L https://github.com/jedisct1/dnscrypt-proxy/releases/download/${VER}/dnscrypt-proxy-linux_${ARCH}-${VER}.tar.gz > dnscrypt-proxy-linux_${ARCH}.tar.gz && \
	tar -xzf dnscrypt-proxy-linux_${ARCH}.tar.gz && \
	mv linux-${ARCH}/dnscrypt-proxy $GOPATH/bin/dnscrypt-proxy && \
	rm -rf dnscrypt-proxy-linux_${ARCH}.tar.gz linux-${ARCH}

RUN addgroup -g 1000 proxy && \
	adduser -u 1000 -G proxy -H proxy -S && \
	touch /etc/dnscrypt-proxy/dnscryptProxy.pid && \
	chown -R proxy:proxy /etc/dnscrypt-proxy

ENTRYPOINT ["/go/bin/dnscrypt-proxy", "-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml", "-pidfile", "/etc/dnscrypt-proxy/dnscryptProxy.pid"]

HEALTHCHECK --interval=15s --timeout=3s --retries=3 CMD dig one.one.one.one || exit 1

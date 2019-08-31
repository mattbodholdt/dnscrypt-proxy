FROM golang:alpine

RUN apk add --update bind-tools curl git && \
	sleep 5 && \
	rm -rf /var/cache/apk/*

ADD dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
ADD test.sh /etc/dnscrypt-proxy/test.sh

ARG ARCH

RUN case $(uname -m) in 				\
	armv71)						\
		ARCH=arm				\
	;;						\
	amd64)						\
		ARCH=x86_64				\
	;;						\
	*)						\
		echo "Unhandled arch!  Please report!"	\
		ARCH=unknown				\
	;;						\
	esac

RUN curl --silent -L https://github.com/jedisct1/dnscrypt-proxy/releases/download/2.0.25/dnscrypt-proxy-linux_${ARCH}-2.0.25.tar.gz > dnscrypt-proxy-linux_${ARCH}.tar.gz && \
	tar -xzf dnscrypt-proxy-linux_${ARCH}.tar.gz && \
	mv linux-${ARCH}/dnscrypt-proxy $GOPATH/bin/dnscrypt-proxy && \
	rm -rf dnscrypt-proxy-linux_${ARCH}.tar.gz linux-${ARCH}

ENTRYPOINT ["/go/bin/dnscrypt-proxy", "-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml"]

HEALTHCHECK CMD dig one.one.one.one || exit 1

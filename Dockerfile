FROM golang:alpine

RUN apk add --update bind-tools curl git && \
	sleep 5 && \
	rm -rf /var/cache/apk/*

ADD dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
ADD test.sh /etc/dnscrypt-proxy/test.sh

RUN case $(uname -m) in 				\
	armv7l)						\
		ARCH=arm				\
	;;						\
	aarch64)					\
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
	VER=2.0.26;					\
	echo "Installing dnscrypt-proxy-${VER} for ${ARCH}";	\
	curl --silent -L https://github.com/jedisct1/dnscrypt-proxy/releases/download/${VER}/dnscrypt-proxy-linux_${ARCH}-${VER}.tar.gz > dnscrypt-proxy-linux_${ARCH}.tar.gz && \
	tar -xzf dnscrypt-proxy-linux_${ARCH}.tar.gz && \
	mv linux-${ARCH}/dnscrypt-proxy $GOPATH/bin/dnscrypt-proxy && \
	rm -rf dnscrypt-proxy-linux_${ARCH}.tar.gz linux-${ARCH}

ENTRYPOINT ["/go/bin/dnscrypt-proxy", "-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml"]

HEALTHCHECK CMD dig one.one.one.one || exit 1

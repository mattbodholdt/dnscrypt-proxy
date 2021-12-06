#!/usr/bin/env sh

set -e

buildArch=${1:-$(uname -m)}

case ${buildArch} in
	armv7l)
		arch=arm
	;;
	arm64|aarch64)
		arch=arm64
	;;
	amd64|x86_64)
		arch=x86_64
	;;
	*)
		echo "Unhandled arch ${buildArch}, exit 1..."
		exit 1
	;;
esac

tag=${2:-"dnscrypt-proxy-${arch}"}

echo "Building for ${arch} and tagging ${tag}..."

docker build -f Dockerfile . -t dnscrypt-proxy-${arch} --no-cache --platform ${arch}

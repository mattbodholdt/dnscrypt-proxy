#!/bin/sh
lookup=$(dig @127.0.0.1 one.one.one.one)

if [ ! -z "$(echo "$lookup" | grep 'connection timed out; no servers could be reached')" ]; then
  lookup2=$(dig @127.0.0.1 one.one.one.one)
  if [ ! -z "$(echo "$lookup2" | grep 'connection timed out; no servers could be reached')" ]; then
    procs=$(ps aux)
    ns=$(netstat -anl)
    echo "$procs"
    echo "$ns"
    echo "$lookup"
    echo "$lookup2"
    exit 1
  fi
else
  echo "$lookup"
fi

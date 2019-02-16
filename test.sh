#!/bin/sh
lookup=$(dig @127.0.0.1 one.one.one.one)

if [ ! -z "$(echo "$lookup" | grep 'connection timed out; no servers could be reached')" ]; then
  procs=$(ps aux)
  ns=$(netstat -anl)
  echo "$procs"
  echo "$ns"
  echo "$lookup"
  exit 1
else
  echo "$lookup"
fi

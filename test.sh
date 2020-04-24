#!/bin/sh

dig @127.0.0.1 one.one.one.one +retry=3 +timeout=10 || fail="true"

if [ "$fail" == "true" ]; then
  procs=$(ps aux)
  ns=$(netstat -anl)
  echo "$procs"
  echo "$ns"
  echo "$lookup"
  exit 1
else
  echo "$lookup"
fi

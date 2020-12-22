
## Linux check port is open
#!/usr/bin/env bash
SERVER=example.com
PORT=80
</dev/tcp/$SERVER/$PORT
if [ "$?" -ne 0 ]; then
  echo "Connection to $SERVER on port $PORT failed"
  exit 1
else
  echo "Connection to $SERVER on port $PORT succeeded"
  exit 0
fi

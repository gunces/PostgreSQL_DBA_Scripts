#!/usr/bin/env bash
SERVER=localhost
PORT=22
nc -z -v -w5 $SERVER $PORT
result1=$?

if [  "$result1" != 0 ]; then
  echo  'port 22 is closed'
else
  echo 'port 22 is open'
fi

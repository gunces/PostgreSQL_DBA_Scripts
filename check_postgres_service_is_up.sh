#!/bin/bash

## check postgres service is running

SQL=`psql -h <host> -p <port> -c "select 1;"`

if [ $? -eq 0 ]; then
    echo OK
    mail -s "Test Subject" gunce.sarikaya@xxxx.xxx.tr  < /dev/null
else
    echo FAIL
fi

#!/bin/bash

nohup /usr/local/spark/sbin/start-history-server.sh &
/usr/local/spark/sbin/start-master.sh

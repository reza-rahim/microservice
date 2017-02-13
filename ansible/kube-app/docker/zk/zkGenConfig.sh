#!/usr/bin/env bash

ZK_DATA_DIR=${ZK_DATA_DIR:-"/var/zookeeper/data"}
ZK_CONF_DIR=${ZK_CONF_DIR:-"/opt/zookeeper/conf"}
ZK_CONFIG_FILE="$ZK_CONF_DIR/zoo.cfg"
ID_FILE="$ZK_DATA_DIR/myid"
HOST=`hostname -s`
DOMAIN=`hostname -d`

if [ -z $ZK_REPLICAS ]; then
        echo "ZK_REPLICAS is a mandatory environment variable"
        exit 1
fi

if [[ $HOST =~ (.*)-([0-9]+)$ ]]; then
        NAME=${BASH_REMATCH[1]}
        ORD=${BASH_REMATCH[2]}
else
        echo "Failed to extract ordinal from hostname $HOST"
        exit 1
fi
   
for (( i=1; i<=$ZK_REPLICAS; i++ ))
do
        echo "server.$i=$NAME-$((i-1)).$DOMAIN:$ZK_SERVER_PORT:$ZK_ELECTION_PORT" >> $ZK_CONFIG_FILE
done

MY_ID=$((ORD+1))
echo $MY_ID >> $ID_FILE

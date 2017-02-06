#!/bin/bash

HOST=`hostname -s`

if [[ $HOST =~ (.*)-([0-9]+)$ ]]; then
        NAME=${BASH_REMATCH[1]}
        ORD=${BASH_REMATCH[2]}
else
        echo "Failed to extract ordinal from hostname $HOST"
        exit 1
fi

BROKER_ID=$((ORD+1))

cat /etc/kafka/server.properties.template | sed "s/{{zookeeper.connect}}/$ZK/g" | sed "s/{{broker.id}}/$BROKER_ID/g" | sed "s/{{num.partitions}}/$NUM_PARTITIONS/g" > /etc/kafka/server.properties

kafka-server-start.sh /etc/kafka/server.properties

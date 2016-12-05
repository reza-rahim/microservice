#!/bin/bash

cat /etc/kafka/server.properties.template | sed "s/{{zookeeper.connect}}/$ZK/g" | sed "s/{{broker.id}}/$BROKER_ID/g" | sed "s/{{num.partitions}}/$NUM_PARTITIONS/g" > /etc/kafka/server.properties

kafka-server-start.sh /etc/kafka/server.properties

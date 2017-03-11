#!/bin/bash

source docker_version.conf

ssh dckreg mkdir -p /var/tmp/kafka
scp kafka/* dckreg:/var/tmp/kafka
ssh dckreg "export KAFKA_SCALA_VERSION=$KAFKA_SCALA_VERSION; export KAFKA_VERSION=$KAFKA_VERSION;cd /var/tmp/kafka;./build.sh"



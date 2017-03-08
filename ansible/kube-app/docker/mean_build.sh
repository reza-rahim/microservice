#!/bin/bash

source docker_version.conf

ssh dckreg mkdir -p /var/tmp/java
scp java/* dckreg:/var/tmp/java
ssh dckreg "cd /var/tmp/java;./build.sh"

ssh dckreg mkdir -p /var/tmp/mongo
scp mongo/* dckreg:/var/tmp/mongo
ssh dckreg "export MONGO_VERSION=$MONGO_VERSION;cd /var/tmp/mongo;./build.sh"

ssh dckreg mkdir -p /var/tmp/nodeapp/docker1/
scp -r nodeapp/docker1/* dckreg:/var/tmp/nodeapp/docker1/
ssh dckreg "cd /var/tmp/nodeapp/docker1/;./build.sh"

ssh dckreg mkdir -p /var/tmp/nodeapp/docker2/
scp -r nodeapp/docker2/* dckreg:/var/tmp/nodeapp/docker2/
ssh dckreg "cd /var/tmp/nodeapp/docker2/;./build.sh"


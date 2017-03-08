#!/bin/bash
mkdir -p /data/db
mkdir -p /data/configdb

mongod --smallfiles

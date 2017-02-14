
###hbase

kubectl -s api:8080 exec -it hm-0 bash

hbase shell

create 'users','info'
put 'users','reza','info:name','reza'
put 'users','reza','info:age','30'
get 'users', 'reza'

flush 'users'
###phx

sqlline.py zk-0.zk
create table test (mykey integer not null primary key, mycolumn varchar);
upsert into test values (1,'Hello');
upsert into test values (2,'World!');
select * from test;

### Zeppline

default.driver : org.apache.phoenix.jdbc.PhoenixDrive
default.url : jdbc:phoenix:zk-0.zk:/hbase


##### kafka test ####
kubectl -s api:8080 exec -it kafka-0 bash
kafka-topics.sh --create --zookeeper zk-0.zk:2181 --replication-factor 1 --partitions 1 --topic test
kafka-topics.sh --list --zookeeper zk-0.zk:2181

kafka-console-producer.sh --broker-list localhost:9092 --topic test
kafka-console-consumer.sh --topic test --from-beginning --zookeeper zk-2.zk:2181

#### hdfs test####
kubectl -s api:8080 exec -it nn-0 bash


#### spark test ###
kubectl -s api:8080 exec -it sm-0 bash
spark-shell --master spark://sm-0.sprkmstr:7077

val textFile = sc.textFile("hdfs://nn-0.nn:9000/data.txt")
textFile.collect().foreach(println)

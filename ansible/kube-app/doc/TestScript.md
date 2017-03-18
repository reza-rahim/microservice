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

##create table message (key integer not null primary key, msg varchar);
### Zeppline

default.driver : org.apache.phoenix.jdbc.PhoenixDrive

default.url : jdbc:phoenix:zk-0.zk:/hbase


##### kafka test ####
kubectl -s api:8080 exec -it kafka-0 bash

## create topic
kafka-topics.sh --create --zookeeper zk-0.zk:2181 --replication-factor 1 --partitions 1 --topic message

kafka-topics.sh --list --zookeeper zk-0.zk:2181

kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic message

## run producer
kafka-console-producer.sh --broker-list kafka-0.kafka:9092 --topic message

kafka-console-consumer.sh --topic message --from-beginning --zookeeper zk-2.zk:2181

kafka-console-consumer.sh --topic message --from-beginning --zookeeper localhost:2181

#### hdfs test####
kubectl -s api:8080 exec -it nn-0 bash

#### spark test ###
kubectl -s api:8080 exec -it sm-0 bash

export SPARK_DIST_CLASSPATH=$(/opt/hadoop/bin/hadoop classpath)

export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop

export YARN_CONF_DIR=/opt/hadoop/etc/hadoop

spark-shell --master spark://sm-0.sm:7077

val textFile = sc.textFile("hdfs://nn-0.nn:9000/data.txt")

val textFile = sc.textFile("/data.txt")

textFile.collect().foreach(println)

##


spark-submit --class Main --master spark://sm-0.sm:7077 

spark-submit --class Streaming --jars /opt/phoenix/phoenix-4.9.0-HBase-1.2-client.jar --master spark://sm-0.sm:7077 


### Stream 
####
spark-shell --jars $(echo /opt/phoenix/*.jar | tr ' ' ',')

import org.apache.spark.sql.types._
import org.apache.spark.sql.functions._
import org.apache.spark.sql.catalyst.ScalaReflection
import java.sql.DriverManager
import java.sql.Connection

class SparkJob extends Serializable {

   import org.apache.spark.sql.types._
   import org.apache.spark.sql.functions._
   import org.apache.spark.sql.catalyst.ScalaReflection
   import java.sql.DriverManager
   import java.sql.Connection
   import spark.implicits._

   val i = 0 
   val driver = "org.apache.phoenix.jdbc.PhoenixDriver"
   Class.forName(driver)
   val connection:Connection = DriverManager.getConnection("jdbc:phoenix:zk-0.zk")
   
   def processRow(msg :String) = {

   }

   def  runJob() = {
     val lines = spark.readStream.format("kafka").option("kafka.bootstrap.servers", "kafka-0.kafka:9092").option("subscribe", "message").load().selectExpr("CAST(value AS STRING)").as[String]
     val writer = new org.apache.spark.sql.ForeachWriter[String]{
        override def open(partitionId: Long, version: Long) = { println ("Opening"); true }
        override def process(msg: String) = {
          processRow(msg)
     }
     override def close(errorOrNull: Throwable) = {}
   }

   lines.writeStream.queryName("Testing").foreach(writer).start
   }
}


sc.addJar("/opt/phoenix/phoenix-4.9.0-HBase-1.2-client.jar")
new SparkJob().runJob
##########
val wordCounts = lines.flatMap(_.split(" ")).groupBy("value").count()
val query = wordCounts.writeStream.outputMode("complete").format("console").start()



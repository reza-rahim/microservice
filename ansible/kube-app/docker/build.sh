ssh dckreg mkdir -p /var/tmp/java
rsync -avg java/ dckreg:/var/tmp/java
ssh dckreg 'cd /var/tmp/java;./build.sh'

ssh dckreg mkdir -p /var/tmp/zk
rsync -avg zk/ dckreg:/var/tmp/zk
ssh dckreg 'cd /var/tmp/zk;./build.sh'

ssh dckreg mkdir -p /var/tmp/kafka
rsync -avg kafka/ dckreg:/var/tmp/kafka
ssh dckreg 'cd /var/tmp/kafka;./build.sh'

ssh dckreg mkdir -p /var/tmp/hdfs
rsync -avg hdfs/ dckreg:/var/tmp/hdfs
ssh dckreg 'cd /var/tmp/hdfs;./build.sh'

ssh dckreg mkdir -p /var/tmp/spark
rsync -avg spark/ dckreg:/var/tmp/spark
ssh dckreg 'cd /var/tmp/spark;./build.sh'

ssh dckreg mkdir -p /var/tmp/hbase
rsync -avg hbase/ dckreg:/var/tmp/hbase
ssh dckreg 'cd /var/tmp/hbase;./build.sh'

ssh dckreg mkdir -p /var/tmp/zeppelin
rsync -avg zeppelin/ dckreg:/var/tmp/zeppelin
ssh dckreg 'cd /var/tmp/zeppelin;./build.sh'


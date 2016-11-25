FROM openjdk:8-jre

ENV HADOOP_VERSION    2.7.0
ENV HADOOP_HOME        /usr/local/hadoop
ENV HADOOP_OPTS        -Djava.library.path=/usr/local/hadoop/lib/native
ENV PATH        $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y sudo wget libzip2 libsnappy1 libssl-dev  && \
    wget http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    apt-get remove -y wget && \
    rm -rf /var/lib/apt/lists/* && \
    tar -zxf /hadoop-$HADOOP_VERSION.tar.gz && \
    rm /hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION /usr/local/hadoop && \
    mkdir -p /usr/local/hadoop/logs

RUN apt-get -y autoremove

RUN useradd -u 9000 -m hdfs 


EXPOSE 9000 50070 50010 50020 50075 50090



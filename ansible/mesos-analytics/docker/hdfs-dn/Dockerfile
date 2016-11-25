FROM  10.0.15.11:5000/hdfs-base:2.7
COPY core-site.xml /usr/local/hadoop/etc/hadoop/
COPY hdfs-site.xml /usr/local/hadoop/etc/hadoop/

RUN chown -R hdfs /usr/local/hadoop/
USER hdfs
CMD ["hdfs", "datanode"]

FROM /hdfs-base:2.7
COPY hdfs-nn.sh /usr/local/hadoop/bin/hdfs-nn.sh
RUN chmod 755 /usr/local/hadoop/bin/hdfs-nn.sh
RUN chown -R hdfs /usr/local/hadoop/
USER hdfs
CMD ["hdfs-nn.sh"]

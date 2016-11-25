FROM 10.0.15.11:5000/hdfs-base:2.7
COPY hdfs-nn.sh /usr/local/hadoop/bin/hdfs-nn.sh
RUN chmod 755 /usr/local/hadoop/bin/hdfs-nn.sh
RUN chown -R hdfs /usr/local/hadoop/
USER hdfs
CMD ["hdfs-nn.sh"]

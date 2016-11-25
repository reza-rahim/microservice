val textFile = sc.textFile("hdfs://10.0.15.11:9000/user/spark/test.file")
textFile.collect().foreach(println)

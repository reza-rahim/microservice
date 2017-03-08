var Kafka = require('node-rdkafka');

var producer = new Kafka.Producer({
  'metadata.broker.list': 'localhost:9092'
});

var stream = producer.getWriteStream('message');


curl -H "Content-Type: application/json" -X POST -d '{"msg" : "kalukhan"}' http://dev:3000/msg

echo '{"msg" : "kalukhan"}' | curl -H "Content-Type: application/json" -X POST -d @- http://dev:3000/msg 




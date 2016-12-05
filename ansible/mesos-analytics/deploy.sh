cd docker
./docker.sh
cd ..
ansible-playbook analytics.yml -i vagrant 
#ansible-playbook analytics.yml -i vagrant --tag  hdfs
#ansible-playbook analytics.yml -i vagrant --tag  spark
#ansible-playbook analytics.yml -i vagrant --tag  hbase
#ansible-playbook analytics.yml -i vagrant --tag  kafka


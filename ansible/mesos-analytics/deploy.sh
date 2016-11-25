ansible-playbook analytics.yml -i hdfs.ini -e "marathon=$MARATHON" -e "docker_registry=$DOCKER_REGISTRY"
ansible-playbook analytics.yml -i spark.ini -e "marathon=$MARATHON" -e "docker_registry=$DOCKER_REGISTRY"

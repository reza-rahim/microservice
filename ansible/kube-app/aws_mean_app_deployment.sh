 #!/bin/bash

source docker/docker_version.conf
source conf/aws_mean_pod.conf

kubectl -s api:8080 create -f deploy/storageclass/awsStorageClass.yml

./mean_app_deployment.sh

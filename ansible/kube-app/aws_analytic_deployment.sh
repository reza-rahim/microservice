 #!/bin/bash

source docker/docker_version.conf
source conf/aws_analytic_pod.conf

kubectl -s api:8080 create -f deploy/storageclass/awsStorageClass.yml

./analytic_deployment.sh

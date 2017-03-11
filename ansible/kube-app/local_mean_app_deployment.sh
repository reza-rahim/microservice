 #!/bin/bash

kubectl -s api:8080 create -f local-pv.yml

source docker/docker_version.conf
source conf/local_mean_pod.conf

./mean_app_deployment.sh

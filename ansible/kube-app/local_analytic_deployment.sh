 #!/bin/bash

source docker/docker_version.conf
source conf/local_analytic_pod.conf

kubectl -s api:8080 create -f local-pv.yml

./analytic_deployment.sh

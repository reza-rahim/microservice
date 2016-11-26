cd docker
./docker.sh
cd ..
ansible-playbook analytics.yml -i vagrant -e "docker_registry=$DOCKER_REGISTRY"

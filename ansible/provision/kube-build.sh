
ansible-playbook -i kube-inventory.ini  kube-docker-registry.yml
./kube-docker.sh
ansible-playbook -i kube-inventory.ini  kube-cluster.yml
sleep 15
sudo rm /var/tmp/addon/*
ansible-playbook -i kube-inventory.ini  kube-addon.yml


ansible-playbook -i kube-inventory.ini  kube-cluster.yml
sleep 30
ansible-playbook -i kube-inventory.ini  kube-addon.yml

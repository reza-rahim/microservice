kubectl -s node1:8080 create -f local-pv.yml
kubectl -s node1:8080 create -f sprkmstr.yml
kubectl -s node1:8080 create -f sprkwrk.yml


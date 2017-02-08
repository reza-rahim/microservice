cd docker
./build.sh
cd ..
kubectl -s node1:8080 create  -f local-pv.yml
kubectl -s node1:8080 create -f zk.yml

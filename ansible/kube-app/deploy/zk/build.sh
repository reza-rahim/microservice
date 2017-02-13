cd docker
./build.sh
cd ..
kubectl -s api:8080 create  -f local-pv.yml
kubectl -s api:8080 create -f zk.yml

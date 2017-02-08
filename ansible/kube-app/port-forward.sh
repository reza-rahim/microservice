ssh vagrant@10.0.15.10 -L 50070:localhost:50070 -L 8080:localhost:8080 -L 8088:localhost:8081 -L 30001:10.0.15.11:30001

kubectl -s node1:8080 port-forward nn-0 50070:50070 &

kubectl -s node1:8080 port-forward sprkmstr-0 8080:8080 &
kubectl -s node1:8080 port-forward sprkwrk-0 8088:8081 &

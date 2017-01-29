./buildall.sh
#kubectl -s node1:8080 expose deployment nodeapp-deployment  --target-port=3000 --type=NodePort

kubectl create -f kube-svc.yml
kubectl -s node1:8080 create  -f kube-dep-1.1.yaml --record

## rolling update
kubectl set image deployment/nodeapp-deployment  nodeapp=dckreg:5000/nodeapp:1.2

##
kubectl rollout history  deployments nodeapp-deployment
kubectl rollout undo deployments nodeapp-deployment --to-revision=1
kubectl rollout undo deployments nodeapp-deployment 

## Scaling app ##
kubectl scale  deployment/nodeapp-deployment --replicas=2


## prometheus
http://10.0.15.11:30001/
container_memory_usage_bytes{container_name="nodeapp"}
container_memory_usage_bytes{container_name="mongo"}
container_cpu_usage_seconds_total{container_name="nodeapp"}


./buildall.sh
#kubectl -s api:8080 expose deployment nodeapp-deployment  --target-port=3000 --type=NodePort

kubectl -s api:8080 create -f nodeapp-svc.yml
kubectl -s api:8080 create  -f nodeapp-1.1.yml --record

## rolling update
kubectl -s api:8080 set image deployment/nodeapp  nodeapp=dckreg:5000/nodeapp:1.2

##
kubectl -s api:8080 rollout history  deployments nodeapp
kubectl -s api:8080 rollout undo deployments nodeapp --to-revision=1
kubectl -s api:8080 rollout undo deployments nodeapp 

## Scaling app ##
kubectl -s api:8080 scale  deployment/nodeapp-deployment --replicas=2


## prometheus
http://10.0.15.11:30001/
container_memory_usage_bytes{container_name="nodeapp"}
container_memory_usage_bytes{container_name="mongo"}
container_cpu_usage_seconds_total{container_name="nodeapp"}


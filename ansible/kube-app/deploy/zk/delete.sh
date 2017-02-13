cat zk.yml | sed -e "s/{{ zk_replicas }}/$ZK_REPLICAS/"  | kubectl -s api:8080 delete -f -

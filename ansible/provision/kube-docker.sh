
### 
sudo docker pull  gcr.io/google_containers/kube-apiserver-amd64:v1.5.2 
sudo docker tag   gcr.io/google_containers/kube-apiserver-amd64:v1.5.2 dckreg:5000/kube-apiserver-amd64:v1.5.2
sudo docker push  dckreg:5000/kube-apiserver-amd64:v1.5.2

sudo docker pull  gcr.io/google_containers/kube-controller-manager-amd64:v1.5.2 
sudo docker tag   gcr.io/google_containers/kube-controller-manager-amd64:v1.5.2 dckreg:5000/kube-controller-manager-amd64:v1.5.2
sudo docker push  dckreg:5000/kube-controller-manager-amd64:v1.5.2

sudo docker pull   gcr.io/google_containers/kube-scheduler-amd64:v1.5.2
sudo docker tag   gcr.io/google_containers/kube-scheduler-amd64:v1.5.2 dckreg:5000/kube-scheduler-amd64:v1.5.2
sudo docker push  dckreg:5000/kube-scheduler-amd64:v1.5.2

##
sudo docker pull  gcr.io/google_containers/kube-proxy-amd64:v1.5.2
sudo docker tag   gcr.io/google_containers/kube-proxy-amd64:v1.5.2 dckreg:5000/kube-proxy-amd64:v1.5.2
sudo docker push  dckreg:5000/kube-proxy-amd64:v1.5.2

sudo docker pull  weaveworks/weave-kube:1.8.2
sudo docker tag   weaveworks/weave-kube:1.8.2 dckreg:5000/weave-kube:1.8.2
sudo docker push  dckreg:5000/weave-kube:1.8.2

sudo docker pull  weaveworks/weave-npc:1.8.2
sudo docker tag   weaveworks/weave-npc:1.8.2 dckreg:5000/weave-npc:1.8.2
sudo docker push  dckreg:5000/weave-npc:1.8.2


sudo docker pull  gcr.io/google_containers/kubedns-amd64:1.9
sudo docker tag   gcr.io/google_containers/kubedns-amd64:1.9  dckreg:5000/kubedns-amd64:1.9
sudo docker push  dckreg:5000/kubedns-amd64:1.9

sudo docker pull  gcr.io/google_containers/kubernetes-dashboard-amd64:v1.5.1
sudo docker tag   gcr.io/google_containers/kubernetes-dashboard-amd64:v1.5.1 dckreg:5000/kubernetes-dashboard-amd64:v1.5.1
sudo docker push  dckreg:5000/kubernetes-dashboard-amd64:v1.5.1

sudo docker pull  quay.io/prometheus/prometheus:v1.0.1
sudo docker tag   quay.io/prometheus/prometheus:v1.0.1  dckreg:5000/prometheus:v1.0.1
sudo docker push  dckreg:5000/prometheus:v1.0.1


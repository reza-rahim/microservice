# Microservice Framework - Mesos/Marathon, Docker, Weave and Flocker


**Vagrant** (1.8.6 or up)
1. [**Youtube Video for Meosos based Deployment On Vagrant**](https://youtu.be/-AMdZjGXMCo)

2. [**Instruction for Meosos based Deployment On Vagrant:**](https://github.com/reza-rahim/microservice/blob/master/MESOS-VAGRANT.md)

**AWS**
  
## Overview of the Framework


**Idempotence** (/ˌaɪdᵻmˈpoʊtəns/ eye-dəm-poh-təns)[1] `is the property of certain operations in mathematics and computer science, that can be applied multiple times without changing the result beyond the initial application. -- Wikipedia` 

`All the build and deployment scripts of the framework are Idempotent. Means that a script only change the system to get to the desired state. If the desired state is present, the script won't changed the system. As a result, we can run any script anytime without casuing any unwanted side-effect.`


1. [**Docker:**](https://www.docker.com/) Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox (called containers) to run on the host operating system i.e. Linux.
2. [**Mesos:**](http://mesos.apache.org/) Apache Mesos is a centralised fault-tolerant cluster manager. It’s designed for distributed computing environments to provide resource isolation and management across a cluster of slave nodes.
  
  A Mesos cluster is made up of four major components:
  1. **ZooKeepers**
  2. **Mesos masters**
  3. **Mesos slaves**
  4. **Frameworks** (such as Marathon )
  

3. [**Marathon:**](https://mesosphere.github.io/marathon/) Mesos only provides the basic “kernel” layer of your cluster. Marathon framework is the equivalent of the Linux upstart or init daemons, designed for long-running applications. 

   ***Marathon framework is repossible for scheduling Docker container and keep them running on Mesos Cluster.***
   
4. [**Weave:**](https://www.weave.works/) Weave Net creates a virtual network that connects Docker containers across multiple hosts and enables their automatic discovery. With Weave Net, portable microservices-based applications consisting of multiple containers can run anywhere: on one host, multiple hosts or even across cloud providers and data centers.

5. [**Flocker:**](https://clusterhq.com/) Flocker is an open-source container data volume manager for Dockerized applications. It helps to move the external persistence volume with the container. For example, if a Docker Container moves from one host another host, Flocker would re-mount the existing volume to the newly provisioned container. So the statefull containers --like database -- can be moved with ease. 


![Image of System Architecture](https://github.com/reza-rahim/microservice/blob/master/picture/SystemArchitecture.png)

There are four vagrant machines 

1. **10.0.16.10(mgmt):** `mgmt` acts as cluster management node. It is used for running various Ansible build and deploy scripts such as building cluster, building Docker images or deploying Marathon jobs.
1. **10.0.15.11(node1):** `node1` holds Zookeeper, Mesos Master and Marathon. It serves as a Mesos slave as well. It also runs special Docker Container called registry. The registry serves as [local Docker registry](https://docs.docker.com/registry/). All application Docker containers get pushed into the local registry before get deployed on the cluster.   
1. **10.0.15.12(node2)** `node3`serves only as a Mesos slaves. It runs application containers.   
1. **10.0.15.13(node3)** `node` serves only as a Mesos slaves. It runs application containers.  

![Image of Process Deployment] (https://github.com/reza-rahim/microservice/blob/master/picture/ProcessDeployment.png)

For example, let's look nodeapp build process:

  - `~/ansible/mesos-app/nodeapp/Dockerfile` contains the logic to build the nodeapp Docker container.
 
  - `~/ansible/mesos-app/nodeapp/ansible/roles/deploy/files/application.json.j2` contains the template for Marathon job. For information how to define a Marathon job please refer to [mesosphere.github.io](https://mesosphere.github.io/marathon/docs/application-basics.html).

  - `~/ansible/mesos-app/nodeapp/deploy_with_docker_build.sh` would build a new Docker image, push the image to local docker registry and deploy the Marathon job
  
  - `~/ansible/mesos-app/nodeapp/deploy_without_docker_build.sh` only deploy the Marathon job. It's helpfull when we are only changing the deploymen parameter such a number of instances or amount of memory for the container.
  
  
![Image of Aplication Architecture] (https://github.com/reza-rahim/microservice/blob/master/picture/AplicationArchitecture.png)

Weave interconnect Docker Containers across Multiple Hosts by creating Sofware Define Network. For example, nodeapp container can be accessed from nginx container by using `nodeapp.weave.local` DNS name. 

Flocker is configured to use ZFS file system. In a cloud environment, the system should be using network persistence volume such as EBS or Ceph. When we move the mongo db Docker container form node2 to node3, `Flocker would move all the data from node2 using ZFS replication feature`.   

### Logging
All Docker containers are configured to use [rsyslog driver](https://docs.docker.com/engine/admin/logging/overview/). Each container goes goes to 

   `/var/log/docker/<app_name>/docker.log`.

Each local rsyslog is set up to forward the local Docker log to central rsyslog server for `log aggregation`. For this application `node1` is set to be the cental log server. On `node1` the centralized log could be found at:

   `/var/log/remote/`

For prodcution system, log could be aggregated using [ELK Stack](https://www.elastic.co/) 

**Mesos and Marathon** related error could be found on the Mesos UI.

**mesos-master, mesos-slave and marathon** runs as systemd service. `journalctl` can be used view their log files. 

`journalctl -u mesos-master`

`journalctl -u mesos-slave`

`journalctl -u marathon`


### Debuging 


log in to `node1` from `mgmt` 
```
   ssh node1
   sudo su
   docker ps
```
```
CONTAINER ID        IMAGE                                          COMMAND                  CREATED             STATUS              PORTS                           NAMES
fa942f9ca616       10.0.15.11:5000/application/app/nginx:1.10.0   "/w/w nginx -g 'daemo"   29 minutes ago      Up 29 minutes       443/tcp, 0.0.0.0:9080->80/tcp   mesos-f5127b14-55b2-491b-af9f-004e2d644890-S2.8b044821-4fff-49be-934c-cc5331d3b7a5
e8e2bd1f14bf        registry:2                                     "/entrypoint.sh /etc/"   About an hour ago   Up About an hour                                    mesos-f5127b14-55b2-491b-af9f-004e2d644890-S2.20cdaa1c-f0e7-470a-a9d9-69b2da047900
0281332620aa        weaveworks/weaveexec:1.7.2                     "/home/weave/weavepro"   About an hour ago   Up About an hour                                    weaveproxy
a259f83ddd41        weaveworks/weave:1.7.2                         "/home/weave/weaver -"   About an hour ago   Up About an hour                                    weave
```

**fa942f9ca616** is the current docker process id for nginx container. Now let's log into the nginx Docker container.

`docker exec -it fa942f9ca616 bash`

your promt should change to:

`root@nginx:/#`

Now we are at the contianer propmt, issue the following command `ip` :

`ip a`

```
15: ethwe@if16: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1410 qdisc noqueue state UP group default
    link/ether ea:f7:30:4c:a2:93 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.2.0.1/16 scope global ethwe
       valid_lft forever preferred_lft forever
    inet6 fe80::e8f7:30ff:fe4c:a293/64 scope link
       valid_lft forever preferred_lft forever
```
**10.2.0.1** is ip for nginx container assigned by weave net.


Now ping the nodeapp container.

`for i in `seq 1 5`; do ping -c 2 nodeapp; done`
```
--- nodeapp.weave.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 999ms
rtt min/avg/max/mdev = 0.472/0.489/0.506/0.017 ms
PING nodeapp.weave.local (10.2.192.0) 56(84) bytes of data.
64 bytes from nodeapp.weave.local (10.2.192.0): icmp_seq=1 ttl=64 time=0.384 ms
64 bytes from nodeapp.weave.local (10.2.192.0): icmp_seq=2 ttl=64 time=0.536 ms

--- nodeapp.weave.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 999ms
rtt min/avg/max/mdev = 0.384/0.460/0.536/0.076 ms
PING nodeapp.weave.local (10.2.128.1) 56(84) bytes of data.
64 bytes from nodeapp.weave.local (10.2.128.1): icmp_seq=1 ttl=64 time=0.472 ms
64 bytes from nodeapp.weave.local (10.2.128.1): icmp_seq=2 ttl=64 time=0.543 ms

```

Ping is returning multiple ip `(10.2.192.0, 10.2.128.1)`. Because there are multiple instances of `nodeapp` container and weave DNS is load balancing between them.  


Let’s look at the nginx configuration file

```
cat /etc/nginx/conf.d/default.conf

server {
    listen 80;

    server_name localhost;

    location / {
        proxy_pass http://nodeapp:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
let's curl the nodejs application running on port 3000 on `nodeapp` container.

`curl http://nodeapp:3000`

`<!DOCTYPE html><html><head><title>Express</title><link rel="stylesheet" href="/stylesheets/style.css"></head><body><h1>Express</h1><p>Welcome to Express</p></body></html>`

## flocker
log back out to `mgmt` node

use `flockerctl` to see all the volumes managed by Flocker.

```
vagrant@mgmt:~$ flockerctl list
/usr/local/bin/flockerctl: 3: read: Illegal option -d
DATASET                                SIZE    METADATA                             STATUS         SERVER
62748416-3d6a-49f2-8583-52ea07d60700   1.00G   maximum_size=1073741824,name=mongo   attached ✅   03e9e291 (10.0.15.12)
```

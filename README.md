# Microservice Framework - Mesos/Marathon, Docker, Weave and Flocker

**Youtube Video: https://youtu.be/-AMdZjGXMCo**

##Instruction:
1. **Clone the git**

git clone https://github.com/reza-rahim/microservice

2. **Change the dir**

   cd microservice

3. **Bring Vagrant machines up**

   vagrant up

4. **Log in to mgmt vagrant box**

   vagrant ssh mgmt

5. **Build the mesos/marathon cluster**

   ./mesos_build_cluster.sh

  1. mesos ui: http://10.0.15.11:5050/  
  2. matathon: http://10.0.15.11:8080/

6. **Deploy the nginx, Node.js and Mongo Db Application**

   source /etc/bash.bashrc <br>

   ./mesos_deploy_app.sh

  1. Application UI: http://10.0.15.11:9080/

7. **Scale up Node.js app from 2 instance to 3 instance**
 
   ./mesos_deploy_scaleup_app.sh

8. **Move the Mongo DB from 10.0.15.12 to 10.0.15.13, the data movement is done by flocker with ZFS file system.**

   ./mesos_move_db.sh

9. **Start the weave scope**

   ./mesos_weave_scope.sh

  1. Weave Scope UI: 10.0.15.10:4040 
  
## Overview of the Framework
1. **Docker:** (https://www.docker.com/) Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox (called containers) to run on the host operating system i.e. Linux.
2. **Mesos:** (http://mesos.apache.org/) Apache Mesos is a centralised fault-tolerant cluster manager. It’s designed for distributed computing environments to provide resource isolation and management across a cluster of slave nodes.
  
  A Mesos cluster is made up of four major components:
  1. **ZooKeepers**
  2. **Mesos masters**
  3. **Mesos slaves**
  4. **Frameworks** (such as Marathon )
  

3. **Marathon:** (https://mesosphere.github.io/marathon/) Mesos only provides the basic “kernel” layer of your cluster. Marathon framework is the equivalent of the Linux upstart or init daemons, designed for long-running applications. 

4. **Weave:** (https://www.weave.works/) Waeve is Software Defined Network (SDN) that provides a unique IP address to each Docker Container over multiple host machines by creating virtual network. As a result, Docker container can directly talk to other Docker Containers from different hosts. Besides that, Weave also provides a DNS like functionality, where Docker Containers can be discovered with DNS like name resolution. 

5. **Flocker:** (https://clusterhq.com/) Flocker is an open-source container data volume manager for Dockerized applications. It helps to move the external persistence volume with the container. For example, if a Docker Container moves from one host another host, Flocker would re-mount the existing volume to the container. So the statefull containers --like database -- can be moved with ease. 


![Image of System Architecture](https://github.com/reza-rahim/microservice/blob/master/picture/SystemArchitecture.png)

There are four vagrant machines 

1. **10.0.15.10(mgmt):** mgmt acts as cluster management node. It is used for running various Ansible build and deploy scripts such as building cluster, building Docker images or deploying Marathon jobs.
1. **10.0.15.11(node1):** node1 holds Zookeeper, Mesos Master and Marathon. It serves as a Mesos slave as well. It also runs special Docker Container called registry. The registry serves as local Docker registry. All application Docker containers get pushed into the local registry before get deployed on the cluster.   
1. **10.0.15.12(node2)** Serves only as a Mesos slaves. It runs application containers.   
1. **10.0.15.13(node3)** Serves only as a Mesos slaves. It runs application containers.  


![Image of Aplication Architecture] (https://github.com/reza-rahim/microservice/blob/master/picture/AplicationArchitecture.png)

Weave provides a virtual network for Docker Container as well DNS for container. For example, nodeapp container can be accessed from nginx container by using nodeapp.weave.local DNS name. 

Flocker is configured to use ZFS file system. In a cloud environment, the system should be using network persistence volume such as EBS or Ceph. When we move the mongo db Docker container form node2 to node3, Flocker would move all the data from node2 using ZFS replication feature.   




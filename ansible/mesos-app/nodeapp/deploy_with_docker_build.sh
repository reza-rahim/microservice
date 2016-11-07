#!/bin/bash

export APP_GROUP=application/app
export APP_ID=nodeapp
export TAG=`date +%Y%m%d%H%M%S`
export INSTANCES=2
export CPUS=0.1
export MEMORY=128
export SLAVETYPE=app
#export CONTAINER_PORT=8000
#export SERVICE_PORT=10010


echo "#!/bin/bash" > remove_images.sh
echo "cd ansible" >> remove_images.sh
chmod 755 remove_images.sh



## clean up the docker registry
TAG_LIST_JSON=`curl -X GET  $DOCKER_REGISTRY/v2/$APP_GROUP/$APP_ID/tags/list`
TAG_LIST_CNT=`echo $TAG_LIST_JSON | jq '.tags | length'`
let TAG_LIST_CNT=$TAG_LIST_CNT-1

COUNTER=0;

while [  $TAG_LIST_CNT -gt $COUNTER ]; do

        OLDTAG=`echo $TAG_LIST_JSON | jq .tags[$COUNTER] | sed 's/^"//'  | sed 's/"$//'`

        SHA=`curl -X GET --head  -H "Accept: application/vnd.docker.distribution.manifest.v2+json" $DOCKER_REGISTRY/v2/$APP_GROUP/$APP_ID/manifests/$OLDTAG  |grep Docker-Content-Digest | sed 's/^Docker-Content-Digest: //' | sed 's/\r//'`

        `curl -X DELETE  $DOCKER_REGISTRY/v2/$APP_GROUP/$APP_ID/manifests/$SHA`

        let COUNTER=$COUNTER+1
        echo "ansible-playbook remove_image.yml -i "localhost," -e \"image_name=$DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$OLDTAG\" " >> remove_images.sh
done

cd docker 

### create docker images
sudo docker build -t $DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$TAG .

if [ "$?" != "0" ]; then
    echo "Failed : docker build -t $DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$TAG ."  
    exit 1
fi

#### push the image  to docker registry
sudo docker push $DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$TAG

if [ "$?" != "0" ]; then
    echo "Failed : docker push $DOCKER_REGISTRY/$APP_GROUP/$APP_ID:$TAG"  
    exit 1
fi


### deploy the app to marathon

cd ..
cd ansible
ansible-playbook deploy.yml  -i "localhost," -e "memory=$MEMORY" -e "cpus=$CPUS" -e "instances=$INSTANCES" -e "app_group=$APP_GROUP" -e "app_id=$APP_ID" -e "tag=$TAG" -e "container_port=$CONTAINER_PORT" -e "service_port=$SERVICE_PORT" -e "slavetype=$SLAVETYPE" -e "marathon=$MARATHON" -e "docker_registry=$DOCKER_REGISTRY"

cd ..
./remove_images.sh
echo "export TAG=${TAG}" > current_tag.sh

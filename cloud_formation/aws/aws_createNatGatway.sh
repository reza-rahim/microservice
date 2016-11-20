#!/bin/bash

if [ -z ${AWS_ACCESS_KEY_ID+x} ];
    then
       echo "AWS_ACCESS_KEY_ID is env variable is not set";
    exit
fi

if [ -z ${AWS_SECRET_ACCESS_KEY+x} ];
    then
       echo "AWS_SECRET_ACCESS_KEY is env variable is not set";
    exit
fi

aws_region=us-east-1

runningNat=$(aws ec2 describe-nat-gateways --region $aws_region --filter "Name=state,Values=available" | jq '.NatGateways | length')

if [ $runningNat == 1 ] 
then
    echo "aws Nat server is  available"
    exit
fi

echo "Creating eip"
eipIp=$(aws ec2 allocate-address --region $aws_region --domain bibs | jq .AllocationId | sed  's/"//g')

echo "searching for vpcid"
vpcId=$(aws ec2 describe-vpcs --region $aws_region --filter "Name=tag-value,Values=bibs" | jq .Vpcs[0].VpcId | sed  's/"//g')

echo "searching for subner id"
subnetId=$(aws ec2 describe-subnets --region $aws_region  --filter "Name=tag-value,Values=prod_public_subnet" | jq .Subnets[0].SubnetId | sed  's/"//g')


echo "creating the Nat gateway "
NatGatewayId=$(aws ec2 create-nat-gateway --region us-east-1 --subnet-id $subnetId  --allocation-id $eipIp | jq .NatGateway.NatGatewayId | sed  's/"//g' )

while : ; do
   runningNat=$(aws ec2 describe-nat-gateways --region $aws_region --filter "Name=state,Values=available" | jq '.NatGateways | length')
   if [ $runningNat == 1 ] 
   then
      echo "aws Nat server is  available"
      break
   fi
   echo "Aws Nat server is not available yet. sleeping 15 second ..."
   sleep 15
done

echo "searching for route table id 1"
routeTableId=$(aws ec2 describe-route-tables --region $aws_region --filters "Name=vpc-id,Values=$vpcId" | jq .RouteTables[0].Associations[0].RouteTableId | sed  's/"//g')

echo "Creating a route table entry with routeTableId=$routeTableId,  NatGatewayId=$NatGatewayId"
rout=$(aws ec2 create-route --region $aws_region --route-table-id $routeTableId  --destination-cidr-block 0.0.0.0/0 --nat-gateway-id $NatGatewayId)

echo "searching for route table id 2"
routeTableId=$(aws ec2 describe-route-tables --region $aws_region --filters "Name=vpc-id,Values=$vpcId" | jq .RouteTables[1].Associations[0].RouteTableId | sed  's/"//g')

echo "Creating a route table entry with routeTableId=$routeTableId,  NatGatewayId=$NatGatewayId"
rout=$(aws ec2 create-route --region $aws_region --route-table-id $routeTableId  --destination-cidr-block 0.0.0.0/0 --nat-gateway-id $NatGatewayId)


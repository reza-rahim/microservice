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

NatGatewayId=$(aws ec2 describe-nat-gateways --region $aws_region | jq .NatGateways[0].NatGatewayId | sed  's/"//g')

$(aws ec2 delete-nat-gateway --region $aws_region --nat-gateway-id $NatGatewayId )
sleep 15

InstanceId=$(aws ec2  describe-instances --region $aws_region | jq .Reservations[0].Instances[0].InstanceId | sed  's/"//g')
$(aws ec2 terminate-instances  --region $aws_region --instance-id $InstanceId)

InstanceId=$(aws ec2  describe-instances --region $aws_region | jq .Reservations[1].Instances[0].InstanceId | sed  's/"//g')
$(aws ec2 terminate-instances  --region $aws_region --instance-id $InstanceId)

InstanceId=$(aws ec2  describe-instances --region $aws_region | jq .Reservations[2].Instances[0].InstanceId | sed  's/"//g')
$(aws ec2 terminate-instances  --region $aws_region --instance-id $InstanceId)

InstanceId=$(aws ec2  describe-instances --region $aws_region | jq .Reservations[3].Instances[0].InstanceId | sed  's/"//g')
$(aws ec2 terminate-instances  --region $aws_region --instance-id $InstanceId)
sleep 60

eip=$(aws ec2 describe-addresses  --region $aws_region | jq .Addresses[0].AllocationId | sed  's/"//g')

$(aws ec2 release-address --region $aws_region --allocation-id $eip)


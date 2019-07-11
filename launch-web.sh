#!/bin/bash

VPCSTACKNAME="$(grep ParamVpcStackName params/launch-web.json | awk '{print $5}' | sed 's/"//g')"

aws --profile "${1}" cloudformation create-stack \
    --stack-name "${VPCSTACKNAME}" \
    --parameters file://params/launch-web.json \
    --template-body file://launch-web.yaml 

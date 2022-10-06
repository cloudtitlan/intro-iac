#!/bin/bash

aws --region us-west-2 \
    cloudformation create-stack \
    --stack-name "intro-iac" \
    --template-body file://ec2.yaml

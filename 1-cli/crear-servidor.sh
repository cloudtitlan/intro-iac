#!/bin/bash

aws --region us-west-2 \
    ec2 run-instances \
    --image-id "ami-08e2d37b6a0129927" \
    --instance-type t2.micro

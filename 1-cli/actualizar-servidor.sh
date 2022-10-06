#!/bin/bash

aws --region us-west-2 \
    ec2 create-tags \
    --resources "" \
    --tags Key=Name,Value=introIaC

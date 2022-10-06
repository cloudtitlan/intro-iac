#!/bin/bash

aws --region us-west-2 \
    ec2 terminate-instances \
    --instance-ids ""

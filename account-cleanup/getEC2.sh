#!/bin/bash
# Author: Ben Todd
# Use: Output list of EC2 for deletion
# 
# 
### Command line input options ###


aws ec2 describe-instances --output text --filters "Name=tag:livefire-lab,Values=vmc-aws" \
                           --query "Reservations[].Instances[].InstanceId" > ec2.instances.txt

code ec2.instances.txt
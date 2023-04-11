# vmc-aws

## Output EC2 Instance List to Text file
aws ec2 describe-instances --output text --filters "Name=tag:livefire-lab,Values=vmc-aws" --query "Reservations[].Instances[].InstanceId"| sed -E 's/\s+/\n/g' > ec2.instances.txt# vmc-aws

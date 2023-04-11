#!/bin/bash


filename=ec2.instances.txt
### Command line input options ###
read -p " Dry Run Yes Or No [Yes]" dry
dryRun=${dry:-Yes}
# echo $dryRun
echo "Deleteing EC2 Instances: in delete file $filename"
ec2list=$(cat $filename)

if [ $dryRun == 'Yes' ]; then

aws ec2 terminate-instances --instance-id $ec2list --dry-run

elif [ $dryRun == 'No' ]; then 

aws ec2 terminate-instances --instance-id $ec2list

else 

    echo "YWrong Choice, Play again"

fi
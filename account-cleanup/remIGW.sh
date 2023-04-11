#!/bin/bash
# Author: Ben Todd
# Use: Output list of EC2 for deletion
# 
# 
### Command line input options ###


### Command line input options ###
read -p " Dry Run Yes Or No [Yes]" dry
dryRun=${dry:-Yes}
# echo $dryRun

for vpcID in $(aws ec2 describe-vpcs  \
        --filters "Name=tag:livefire-lab,Values=vmc-aws" \
        --query "Vpcs[].VpcId" \
        --output text)
    do
       
        for igwID in $(aws ec2 describe-internet-gateways \
                --filters Name=attachment.vpc-id,Values=$vpcID \
                --query "InternetGateways[].InternetGatewayId" \
                --output text)
                
                do

                if [ $dryRun == 'Yes' ]; then

                    echo "Detaching: IGW " $igwID "For VPC: " $vpcID
                    aws ec2 detach-internet-gateway --internet-gateway-id $igwID --vpc-id $vpcID --dry-run
                    echo "Deleteing: IGW" $igwID 
                    aws ec2 delete-internet-gateway --internet-gateway-id $igwID --dry-run

                elif [ $dryRun == 'No' ]; then 


                    echo "Detaching: IGW " $igwID "For VPC: " $vpcID
                    aws ec2 detach-internet-gateway --internet-gateway-id $igwID --vpc-id $vpcID
                    echo "Deleteing: IGW" $igwID 
                    aws ec2 delete-internet-gateway --internet-gateway-id $igwID

                else 

                    echo "YWrong Choice, Play again"

                fi

                done

    done

# code sg.list.txt






# rm ./sg.list.txt
# rm ./ig.list.txt
# for vpcID in $(aws ec2 describe-vpcs  \
#         --filters "Name=tag:livefire-lab,Values=vmc-aws" \
#         --query "Vpcs[].VpcId" \
#         --output text)
#     do
#         #  echo $vpcID >> sg.list.txt
#         #  aws ec2 describe-security-groups --filters Name=vpc-id,Values=$vpcID --query "SecurityGroups[].GroupId" --output text >> sg.list.txt
#         aws ec2 delete-security-groups --filters Name=vpc-id,Values=$vpcID --query "SecurityGroups[].GroupId" --output text >> sg.list.txt

#         #  echo $vpcID >> ig.list.txt
#         #  aws ec2 describe-internet-gateways --filters Name=attachment.vpc-id,Values=$vpcID -query --output text >> ig.list.txt

#     done

# code sg.list.txt
# aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$vpcID 
# aws ec2 describe-subnets --filters 'Name=vpc-id,Values='$vpcID | grep SubnetId
# aws ec2 describe-route-tables --filters 'Name=vpc-id,Values='$vpcID | grep RouteTableId
# aws ec2 describe-network-acls --filters 'Name=vpc-id,Values='$vpcID | grep NetworkAclId
# aws ec2 describe-vpc-peering-connections --filters 'Name=requester-vpc-info.vpc-id,Values='$vpcID | grep VpcPeeringConnectionId
# aws ec2 describe-vpc-endpoints --filters 'Name=vpc-id,Values='$vpcID | grep VpcEndpointId
# aws ec2 describe-nat-gateways --filter 'Name=vpc-id,Values='$vpcID | grep NatGatewayId
# aws ec2 describe-security-groups --filters 'Name=vpc-id,Values='$vpcID | grep GroupId
# aws ec2 describe-instances --filters 'Name=vpc-id,Values='$vpcID | grep InstanceId
# aws ec2 describe-vpn-connections --filters 'Name=vpc-id,Values='$vpcID | grep VpnConnectionId
# aws ec2 describe-vpn-gateways --filters 'Name=attachment.vpc-id,Values='$vpcID | grep VpnGatewayId
# aws ec2 describe-network-interfaces --filters 'Name=vpc-id,Values='$vpcID | grep NetworkInterfaceId
#Simple scripts to remove 22 open to public rule and add office IP for the same
#2 Inputs are required - $1 regionid and $2 securitygroupid


echo "Removing 22 Public Rule : $2"

aws ec2 revoke-security-group-ingress --group-id $2 --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $1


echo "Authorizing 22 Office Rule $2"

aws ec2 authorize-security-group-ingress --group-id $2 --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "OFFICEIP/32"}]}]' --region $1


aws ec2 authorize-security-group-ingress --group-id $2 --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "OFFICEIP2/32"}]}]' --region $1

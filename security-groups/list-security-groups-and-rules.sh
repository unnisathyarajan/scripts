#Quick dirty script to list all region, all security groups, all rules.
#!/bin/bash


REGIONS=(`aws ec2 describe-regions --region us-west-1 --output text | awk '{print $3}' `)
for REGION in ${REGIONS[*]}; do
	echo "=> $REGION"
        
	SGIDS=(`aws ec2 describe-instances --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupId' --output text --region $REGION --filters "Name=instance-state-name,Values=running"`)

	for SGID in ${SGIDS[*]}; do
		aws ec2 describe-security-groups --group-ids $SGID --region $REGION  --output text
	done
done

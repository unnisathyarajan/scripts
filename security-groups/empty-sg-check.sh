#Cleaning up unsued security groups in account.
#Verify if Security Group is associated or not, if not then delete it after confirmation.



aws ec2 describe-instances --region $1 --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,IP:PublicIpAddress,Region:Placement.AvailabilityZone,Key:KeyName,SG:SecurityGroups}'   --output text | grep -B 1 $2  >> output-descibe-cmd.txt



if [ "$?" = "1" ]; then
	aws ec2 describe-security-groups --group-ids $2 --query 'SecurityGroups[*].{Name:GroupName,Info:Description}'  --output table --region $1
	echo "Delete ? (y/n) : " && read myinput
	case "$myinput" in
        y)
            aws ec2 delete-security-group --group-id $2  --region $1
            echo "SG Deleted"
            ;;
         
        n)
            echo "Deletion Aborted"
            echo "$1  $2 "  >> Used-SG.txt
            ;;
	esac	

else
	echo "$2 has EC2 associated"
	echo "$1  $2 "  >> Used-SG.txt

fi

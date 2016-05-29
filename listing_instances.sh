

aws ec2 describe-instances --region eu-central-1 --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,IP:PublicIpAddress,PrivIP:PrivateIpAddress,Region:Placement.AvailabilityZone,Key:KeyName,Name:Tags[?Key==`Name`].Value[]}' --filter "Name=instance-state-name,Values=running" --output text > /var/www/html/dump2

aws ec2 describe-instances --region us-west-1 --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,IP:PublicIpAddress,PrivIP:PrivateIpAddress,Region:Placement.AvailabilityZone,Key:KeyName,Name:Tags[?Key==`Name`].Value[]}' --filter "Name=instance-state-name,Values=running" --output text >> /var/www/html/dump2

aws ec2 describe-instances --region us-east-1 --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,IP:PublicIpAddress,PrivIP:PrivateIpAddress,Region:Placement.AvailabilityZone,Key:KeyName,Name:Tags[?Key==`Name`].Value[]}' --filter "Name=instance-state-name,Values=running" --output text >> /var/www/html/dump2

aws ec2 describe-instances --region us-west-2 --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,IP:PublicIpAddress,PrivIP:PrivateIpAddress,Region:Placement.AvailabilityZone,Key:KeyName,Name:Tags[?Key==`Name`].Value[]}' --filter "Name=instance-state-name,Values=running" --output text >> /var/www/html/dump2

aws ec2 describe-instances --region eu-west-1 --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,IP:PublicIpAddress,PrivIP:PrivateIpAddress,Region:Placement.AvailabilityZone,Key:KeyName,Name:Tags[?Key==`Name`].Value[]}' --filter "Name=instance-state-name,Values=running" --output text >> /var/www/html/dump2

aws ec2 describe-instances --region ap-southeast-2 --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,IP:PublicIpAddress,PrivIP:PrivateIpAddress,Region:Placement.AvailabilityZone,Key:KeyName,Name:Tags[?Key==`Name`].Value[]}' --filter "Name=instance-state-name,Values=running" --output text >> /var/www/html/dump2



echo "REFERENCE" >> /var/www/html/dump2
echo "us-west-1 : CALIFORNIA"  >> /var/www/html/dump2
echo "us-east-1 : VIRGINIA"  >> /var/www/html/dump2
echo "us-west-2 : OREGON"  >> /var/www/html/dump2
echo "eu-west-1 : IRELAND"  >> /var/www/html/dump2
echo "eu-central-1 : FRANKFURT"  >> /var/www/html/dump2
echo "ap-southeast-2 : SYDNEY"  >> /var/www/html/dump2



txt2html /var/www/html/dump2 > /var/www/html/listec2name

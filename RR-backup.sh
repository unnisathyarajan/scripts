#!/bin/bash

DATE=`date +%d-%m-%Y`

/usr/local/bin/cli53 export AAABBBBXXXZZZZYYYY > zonefiles/foobaa.com.zonefile_$DATE

/usr/local/bin/aws s3 sync zonefiles/ s3://my.domain.backup/  --region us-west-1

#Clear files that are >30 days old.
/usr/bin/find /home/route53/zonefiles/ -mtime +30 -exec rm  {} \;


#!/bin/bash

#Command to initiate backup
/usr/bin/gitlab-rake gitlab:backup:create

now_date=`date +%d-%m-%Y`

cp /etc/gitlab/gitlab-secrets.json /var/opt/gitlab/backups/

#Rename with date appended
mv /var/opt/gitlab/backups/gitlab-secrets.json /var/opt/gitlab/backups/gitlab-secrets.json.$now_date

/usr/bin/aws s3 sync /var/opt/gitlab/backups/ s3://aa.gitlab.backup/ --region eu-west-1

#Deleting files older than 7 days.
/usr/bin/find /var/opt/gitlab/backups/ -mtime +7 -exec rm  {} \;


<script src="https://gist.github.com/unnisathyarajan/29f2c7f232d74f181361de63a88ecd60.js"></script>

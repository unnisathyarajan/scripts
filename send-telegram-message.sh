#!/bin/bash
msg="send_photo"
#$1 input argument to mention contact
#$2 absolute path to the file.

(echo "contact_list"; sleep 10; echo "$msg $1  $2") | /home/unni/tg/bin/telegram-cli


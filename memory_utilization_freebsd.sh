#Install freecolor : "pkg install freecolor"
#Get Memory Utilization in %

#!/usr/local/bin/bash

USED=`freecolor -m -o | grep "Mem:" | awk '{print $3}'`
TOTAL=`freecolor -m -o | grep "Mem:" | awk '{print $2}'`


echo - | awk '{print '$USED' / '$TOTAL' * 100 }'

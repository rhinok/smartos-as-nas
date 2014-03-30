#!/usr/bin/bash

status=`/opt/local/bin/upsc mustek@localhost | wc -l | awk '{ print $1 }'`
if [ ${status} -lt 3 ]
then
  #svcadm disable svc:/site/ups-nut
  /opt/custom/share/svc/ups-nut.sh stop
  sleep 3
  #svcadm enable svc:/site/ups-nut
  /opt/custom/share/svc/ups-nut.sh start
fi

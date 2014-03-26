#!/usr/bin/bash

status=`upsc mustek@localhost | wc -l | awk '{ print $1 }'`
if [ ${status} -lt 3 ]
then
  svcadm disable svc:/site/ups-nut
  sleep 3
  svcadm enable svc:/site/ups-nut
fi

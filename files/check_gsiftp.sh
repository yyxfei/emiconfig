#!/bin/bash
service dpm-gsiftp status
if [ "$?" != "0" ]; then
  chkconfig  --list dpm-gsiftp |grep '3:on'
  if [ "$?" = "0" ]; then
    echo `date ` ":restart dpm-gsiftp service"  >> /var/log/check_gsiftp.log
    service dpm-gsiftp restart
  fi
fi

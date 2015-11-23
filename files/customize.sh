#!/bin/bash
#
# Edit customize.sh as you wish to customize squid.conf.
# It will not be overwritten by upgrades.
# See customhelps.awk for information on predefined edit functions.
# In order to test changes to this, run this to regenerate squid.conf:
#       service frontier-squid
# and to reload the changes into a running squid use
#       service frontier-squid reload
# Avoid single quotes in the awk source or you have to protect them from bash.
#

awk --file `dirname $0`/customhelps.awk --source '{
setoption("acl NET_LOCAL src", "202.122.33.0/255.255.255.0 192.168.0.0/255.255.0.0 202.114.78.125/32 172.16.52.31/32 159.226.49.0/24 128.142.192.53/32 130.87.106.106/32 202.122.35.0/255.255.255.0")
setoption("acl HOST_MONITOR src", "157.82.112.0/21 131.225.209.5/32  127.0.0.1/32 128.142.202.212/32 172.16.52.31/32 159.226.49.0/24 128.142.192.53/32")
setoption("cache_mem", "8192 MB")
setoptionparameter("cache_dir", 3, "10000")
uncomment("acl MAJOR_CVMFS")
print
}'

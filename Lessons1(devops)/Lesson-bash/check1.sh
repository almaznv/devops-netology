#!/usr/bin/env bash

#set -euxo pipefail
try_count=5
hosts=("173.194.222.113" "192.168.0.1" "87.250.250.242")

echo "start requests" > log.log

for host in ${hosts[@]}
do

i=0
stop=0

   while (( i < try_count ))
   do
	curl --connect-timeout 1 http://${host}

	if (($? != 0))
	then
		echo [$(date)] ${host} not available >> error.log
		stop=1
		break
		
	else
		echo [$(date)] ${host} available >> log.log
	fi

	i=$((i+1))
   done

   if (( stop == 1 ))
   then
	break
   fi	   

done

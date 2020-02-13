#!/bin/bash

####Este script realiza o teste de conexão com Radiuss#####

#while true

#do

# START #

#cron -f&

now="$(date +'%Y%m%d%H%M')" > /etc/null 2>&1

echo "$now" >> /home/nocadmin/tmp/logradius.txt

comando="$(radtest 4a78f252-91bb-4185-bee8-756bcad7f26f 44419126 serverradius 10 senharadius)"  # /etc/null 2>&1 

echo $comando >> /home/nocadmin/tmp/logradius.txt

status=$?

#while sleep 10

#do

if [ $status -eq 0 ]; 

then

 echo "$status" #> /home/nocadmin/tmp/statusradius.txt

else

 echo "$status" #> /home/nocadmin/tmp/statusradius.txt 

fi

#unset TMOUT

#sleep 5

# END #

#done

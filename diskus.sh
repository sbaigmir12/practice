#!/bin/bash
DATE=$(date +%F)
LOGDIR=/tmp
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$0.log

R="/e[30m"
G="/e[31m"
Y="/e[33m"

disk_usage=$(df -hT | grep -vE 'tmpfs|fileSystem')
#Threshold
disk_usage_threshold=1
message=""
while IFS= read line
do  
    usage=$(echo $line | awk '{print $6}' | cut -d % -f1)
    partition=$(echo $line | awk '{print $1}')
    if [ $usage -gt $disk_usage_threshold ];
    then
       message+="HARD DISK USAGE is $partition: $usage\n"
    fi
done <<< $disk_usage

echo -e "message: $message"

sh mail.sh sattarbaig786@gmail.com "High Disk Usage" "$message" "Devops team" "High Disk Usage"

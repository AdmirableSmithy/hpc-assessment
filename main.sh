#!/bin/bash

# get disk space in human readable format to ensure GB display 
home_space_available=$(df -h /home | awk 'NR==2 {print $4}')
echo "Available disk space of /home is:" $home_space_available

# get disk space usage as integer (i.e. take off percentage sign)
home_space_usage_percentage=$(df -h /home | awk 'NR==2 {print $5}' | sed 's/%//')

# get disk space used up in GB
home_space_used=$(df -h /home | awk 'NR==2 {print $3}')

if [ $home_space_usage_percentage -gt 70 ]
then
    echo "WARNING! $home_space_usage_percentage% used is greater than 70%"
    echo "Space available:" $home_space_available
    echo "Space used:" $home_space_used
fi

echo "Comments of crontab commands:" $cron_comments
crontab -l | grep -E '^#.*' | sed 's/^#//'

echo "MEMORY REPORT"
echo "Total: $(free -h | awk 'NR==2 {print $2}')"
echo "Used: $(free -h | awk 'NR==2 {print $3}')"
echo "Free: $(free -h | awk 'NR==2 {print $4}')"

mount_count=$(mount | grep "" -c)
echo "Number of mount points: $mount_count"
if [ $mount_count -lt 10 ]
then
    echo "WARNING! Number of mount points $mount_count is less than 10"
fi

# have to ensure SLURM is actually installed
# need to have conf file in etc 

# echo "Number of SLURM tasks in the queue: $slurm_task_count"


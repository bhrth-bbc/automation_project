#! /bin/bash
sudo apt update -y
sudo apt install apache2
service apache2 status | grep -i running
if [ $? -eq 0 ]; then
            echo "Apache2 is already running"
    else
                service apache2 start
fi
timestamp =$(date '+%d%m%Y-%H%M%S')
name =$(bharath)
s3_bucket =${upgrad-bharath}
tar -cvf /tmp/${name}-httpd-logs-${timestamp}.tar /var/log/apache2/access.log
aws s3 \
        cp /tmp/${name}-httpd-logs-${timestamp}.tar \
        s3://${s3_bucket}/${name}-httpd-logs-${timestamp}.tar
#!/bin/bash
yum install httpd -y
echo "<h2> Java Home terraform Demo </h2>" > /var/www/html/index.html
chkconfig httpd on
service httpd start
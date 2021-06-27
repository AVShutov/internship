#!/bin/bash
yum -y update
yum -y install httpd
os=`cat /etc/system-release`
intip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
extip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
echo "<h2>WebServer with<br>Internal IP: $intip<br>External IP: $extip<br>OS: $os</h2><br>"  >  /var/www/html/index.html
echo "<br><font color="blue">Hello World!!!" >> /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
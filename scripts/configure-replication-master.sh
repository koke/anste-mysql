#!/bin/sh

echo > /etc/my.cnf <<EOF
[mysqld]
log-bin=mysql-bin
EOF
invoke-rc.d mysql restart
mysql -e "GRANT REPLICATION SLAVE to 'slave'@'192.168.2.2' IDENTIFIED BY 'slavepass'"

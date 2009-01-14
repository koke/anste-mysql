#!/bin/sh

mysql -e "GRANT REPLICATION SLAVE to 'slave'@'192.168.2.2' IDENTIFIED BY 'slavepass'"

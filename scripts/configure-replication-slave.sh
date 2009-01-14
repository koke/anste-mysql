#!/bin/sh

HOST=192.168.2.1
USER=slave
PASS=slavepass
MASTER="mysql -h $HOST -u $USER -p$PASS"
BINLOG=`$MASTER -e 'show master logs' --batch --skip-column-names`
BINFILE=`echo $BINLOG | cut -d' ' -f 2`
BINPOS=`echo $BINLOG | cut -d' ' -f 2`
mysql -u root <<EOF
CHANGE MASTER TO 
	MASTER_HOST='$HOST', 
	MASTER_USER='$USER', 
	MASTER_PASSWORD='$PASS', 
	MASTER_PORT=3306, 
	MASTER_LOG_FILE='$BINFILE', 
	MASTER_LOG_POS=$BINPOS;

SLAVE START;
EOF

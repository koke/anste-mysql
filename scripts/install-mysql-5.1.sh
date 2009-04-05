#!/bin/bash

TMPDIR=`mktemp -d /tmp/anste-mysql.XXXXXXXXX`
MIRROR='mysql.rediris.es'
MYSQL_VERSION='mysql-cluster-gpl-6.3.20-linux-x86_64-glibc23'
cd $TMPDIR
#wget http://$MIRROR/Downloads/MySQL-5.1/$MYSQL_VERSION.tar.gz || exit 1
wget http://10.6.7.1/$MYSQL_VERSION.tar.gz || exit 1
tar xvf $MYSQL_VERSION.tar.gz
mv $MYSQL_VERSION /usr/local
ln -s /usr/local/$MYSQL_VERSION /usr/local/mysql
pushd /usr/local/mysql
adduser --system --no-create-home mysql
./scripts/mysql_install_db
chown -R root: /usr/local/mysql
chown -R mysql: /usr/local/mysql/data
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
update-rc.d mysql defaults
invoke-rc.d mysql start
cd -
echo 'export PATH=/usr/local/mysql/bin:$PATH' >> /etc/bash.bashrc
echo 'export PATH=/usr/local/mysql/bin:$PATH' >> /etc/profile

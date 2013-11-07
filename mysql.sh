#!/bin/bash
MYSQL=/tmp/mysql/
MYSQLVER=mysql-5.5.34.tar.gz
GETMYSQL() {
	ping -c 3  140.112.2.5
	[ -d $MYSQL ] ||mkdir $MYSQL -p
	if [ $? -eq 0 ]
		then
			wget -nc ftp://ftp.ntu.edu.tw/pub/MySQL/Downloads/MySQL-5.5/mysql-5.5.34.tar.gz -P $MYSQL
	fi
	
}
INSTALL_PACK() {
		for i in gcc gcc-c++ cmake  ncurses-devel;do yum -y install $i;done
}
INSTALL_MYSQL() {
		cd $MYSQL;tar xfz $MYSQLVER
		cd $MYSQL/mysql*; /usr/bin/cmake . && make && make install

}
ADDU() {
	grep "mysql" /etc/passwd
	if [ $? -eq 0 ];then
			echo "mysql is alread"
		else
			groupadd mysql && useradd -g mysql -s /sbin/nologin mysql
	fi
}

GETMYSQL && INSTALL_PACK && ADDU && INSTALL_MYSQL

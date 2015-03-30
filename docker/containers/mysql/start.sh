#!bin/bash
datadir=${DATADIR}

# Initial Setup
if [ ! -d "$datadir/mysql" ] ; then
    mysql_install_db
    mysqld_safe &
    sleep 10
    mysqladmin -u root password ${ROOTPASSWD}
    mysql -e "CREATE DATABASE ${DBNAME}" -p${ROOTPASSWD}
    mysql -e "CREATE USER '${DBUSER}'@'%' IDENTIFIED BY '${DBPASSWD}';" -p${ROOTPASSWD}
    mysql -e "GRANT ALL PRIVILEGES ON ${DBNAME}.* TO '${DBUSER}'@'%';" -p${ROOTPASSWD}
    mysql -e "USE ${DBNAME};SOURCE ${DBSOURCEPATH};" -p${ROOTPASSWD}

    mysql -e "CREATE DATABASE ${DBTESTNAME}" -p${ROOTPASSWD}
    mysql -e "CREATE USER '${DBUSER}'@'%' IDENTIFIED BY '${DBPASSWD}';" -p${ROOTPASSWD}
    mysql -e "GRANT ALL PRIVILEGES ON ${DBTESTNAME}.* TO '${DBUSER}'@'%';" -p${ROOTPASSWD}
    mysql -e "USE ${DBTESTNAME};SOURCE ${DBSOURCEPATH};" -p${ROOTPASSWD}
    killall mysqld
    sleep 10
fi

mysqld_safe

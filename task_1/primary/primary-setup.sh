#!/bin/bash

# SERVER SPECIFIC SETTINGS
PRIMARY_IP="206.189.106.237" # PRIMARY NODE IP
REPLICA_IP="206.189.108.74"
MYSQL_CONFIG_FILE="primary.mysql.conf" # OUR PREPPED CONFIG
MYSQL="/usr/bin/mysql" # PATH TO MYSQL (CRONTAB SAFE)
MYSQL_USER="root" #Root
MYSQL_PASS="password" # a mysql password
MYSQL_PORT=5566
REPLICA_USERNAME="replica"
REPLICA_PASSWORD="replication_password" # for example only

echo "Updating Packages."
sudo apt-get update -y
echo "Package update complete."

echo "Installing and Starting MySQL Server."
sudo apt-get -y install mysql-server
echo "Finished Installing MySQL"
sudo service start mysql
echo "Finished starting MySQL"

echo "*** Perform mysql_secure_installation. *** Answer n to Secure Password Option, y to everything else."

sudo mysql_secure_installation




echo "Starting Configuring MySQL."
echo "Backup standard MySQL Config file."
sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.orig # BACKUP
sudo rm /etc/mysql/mysql.conf.d/mysqld.cnf # REMOVE
sudo cp $MYSQL_CONFIG_FILE /etc/mysql/mysql.conf.d/mysqld.cnf # REPLACE
echo "Config Updated. Restarting Mysql."
sudo sudo service mysql restart
echo "MySQL Restarted."

echo "Changing MySQL root password to user specified."
$MYSQL -u $MYSQL_USER  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_PASS'" 2>/dev/null
$MYSQL -u $MYSQL_USER  -e "FLUSH PRIVILEGES" 2>/dev/null
echo "Updated MySQL root password."



echo "Adding Replica User to MySQL"
$MYSQL -u $MYSQL_USER -p"$MYSQL_PASS" -e "CREATE USER '$REPLICA_USERNAME'@'$REPLICA_IP' IDENTIFIED WITH 'mysql_native_password' BY '$REPLICA_PASSWORD'" 2>/dev/null
$MYSQL -u $MYSQL_USER -p"$MYSQL_PASS" -e "GRANT REPLICATION SLAVE ON *.* TO '$REPLICA_USERNAME'@'$REPLICA_IP'" 2>/dev/null
$MYSQL -u $MYSQL_USER -p"$MYSQL_PASS" -e "FLUSH PRIVILEGES" 2>/dev/null

echo "Finalising...."
echo "MySQL Log file for Replica setup: " 
$MYSQL -u $MYSQL_USER -p"$MYSQL_PASS" -e "show master status\G" 2>/dev/null | grep "File"| cut -d ":" -f2
echo "MySQL Position for Replica setup: "
$MYSQL -u $MYSQL_USER -p"$MYSQL_PASS" -e "show master status\G" 2>/dev/null | grep "Position"| cut -d ":" -f2





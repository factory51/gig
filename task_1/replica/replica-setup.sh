#! /bin/bash

# Supplied from output on Primary
BINLOG_FILE=""
BINLOG_POS=""

# SERVER SPECIFIC SETTINGS
PRIMARY_IP="206.189.106.237" # PRIMARY NODE IP
REPLICA_IP="206.189.108.74"
MYSQL_CONFIG_FILE="replica.mysql.conf" # OUR PREPPED CONFIG
MYSQL="/usr/bin/mysql" # PATH TO MYSQL (CRONTAB SAFE)
MYSQL_USER="root"
MYSQL_PASS="password"
MYSQL_PORT=5566
REPLICA_USERNAME="replica"
REPLICA_PASSWORD="replication_password" # for example only

function show_usage {
  echo "Usage: $0 --file <file_value> --position <position_value>"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --file)
      if [ -n "$2" ]; then
        BINLOG_FILE="$2"
        shift 2
      else
        show_usage
      fi
      ;;
    --position)
      if [ -n "$2" ]; then
        BINLOG_POS="$2"
        shift 2
      else
        show_usage
      fi
      ;;
    *)
      break
      ;;
  esac
done

if [ -z "$BINLOG_FILE" ] || [ -z "$BINLOG_POS" ]; then
  show_usage
fi


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

echo "Changing MySQL root password to user specified."
$MYSQL -u $MYSQL_USER  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_PASS'" 2>/dev/null
$MYSQL -u $MYSQL_USER  -e "FLUSH PRIVILEGES" 2>/dev/null
echo "Updated MySQL root password."



echo "Starting Configuring MySQL."
echo "Backup standard MySQL Config file."
sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.orig # BACKUP
sudo rm /etc/mysql/mysql.conf.d/mysqld.cnf # REMOVE
sudo cp $MYSQL_CONFIG_FILE /etc/mysql/mysql.conf.d/mysqld.cnf # REPLACE
echo "Config Updated. Restarting Mysql."
sudo sudo service mysql restart
echo "MySQL Restarted."

echo "Connecting Replica to Primary"
$MYSQL -u $MYSQL_USER -p"$MYSQL_PASS" -e "CHANGE MASTER TO MASTER_HOST='$PRIMARY_IP', MASTER_PORT=$MYSQL_PORT, MASTER_USER='$REPLICA_USERNAME', MASTER_PASSWORD='$REPLICA_PASSWORD', MASTER_LOG_FILE='$BINLOG_FILE', MASTER_LOG_POS=$BINLOG_POS"
$MYSQL -u $MYSQL_USER -p"$MYSQL_PASS" -e "START SLAVE" 

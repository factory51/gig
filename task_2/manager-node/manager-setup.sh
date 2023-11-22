#! /bin/bash

CLUSTER_PKG="https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster-community-management-server_8.2.0-1ubuntu23.10_amd64.deb"
CLUSTER_FILE="mysql-cluster-community-management-server_8.2.0-1ubuntu23.10_amd64.deb"
MYSQL_CONFIG_FILE="managemet.mysql.conf"
SERVICE_FILE="ndb_mgmd.service"

echo "Updating Packages."
sudo apt-get update -y
echo "Package update complete."

echo "Downloading NDB Cluster *.deb."
sudo curl -sSLO $CLUSTER_PKG

echo "Installing MySQL NDB Management Cluster"
sudo dpkg -i $CLUSTER_FILE

echo "Creating Config Files."
sudo mkdir /var/lib/mysql-cluster/
sudo cp $MYSQL_CONFIG_FILE /var/lib/mysql-cluster/config.ini

echo "Adding NDB DAEMON to auto start services."
sudo cp $SERVICE_FILE /etc/systemd/system/$SERVICE_FILE
sudo systemctl daemon-reload # reload
sudo systemctl enable ndb_mgmd # enable

echo "Starting NDB Cluster Manager"
sudo systemctl start ndb_mgmd # start





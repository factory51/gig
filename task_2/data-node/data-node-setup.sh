# !/bin/bash

DATA_NODE_PKG="https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster-community-data-node_8.2.0-1ubuntu23.10_amd64.deb"
DATA_NODE_FILE="mysql-cluster-community-data-node_8.2.0-1ubuntu23.10_amd64.deb"
MYSQL_CONFIG_FILE="data-node.cnf"
SERVICE_FILE="ndbd.service"

echo "Updating Packages."
sudo apt-get update -y
echo "Package update complete."

echo "Downloading NDB Data Node *.deb."
sudo curl -sSLO $DATA_NODE_PKG
sudo apt-get -y install libclass-methodmaker-perl # Install a required dependancy
sudo dpkg -i $DATA_NODE_FILE

echo "Creating Config Files and folders"
sudo cp $MYSQL_CONFIG_FILE /etc/my.cnf
sudo mkdir -p /usr/local/mysql/data

echo "Adding NDB DATA Node to auto start services."
sudo cp $SERVICE_FILE /etc/systemd/system/$SERVICE_FILE
sudo systemctl daemon-reload # reload
sudo systemctl enable ndbd # enable


echo "Starting NDB Data Node"
sudo systemctl start ndbd # start




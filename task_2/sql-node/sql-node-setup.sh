#! /bin/bash

echo "Updating Packages."
sudo apt-get update -y
echo "Package update complete."


SQL_NODE_FILE="https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster_8.2.0-1ubuntu23.10_amd64.deb-bundle.tar"
MYSQL_CONFIG_FILE="sql-node.cnf"

echo "Updating Packages."
sudo apt-get update -y
echo "Package update complete."

echo "Downloading NDB SQL Node *.tar."
sudo curl -sSLO $SQL_NODE_FILE

echo "Unpacking $SQL_NODE_FILE."
sudo tar -xvf mysql-cluster_8.2.0-1ubuntu23.10_amd64.deb-bundle.tar

echo "Installing Packages and Dependancies."
sudo apt-get -y install libmecab2
sudo dpkg -i mysql-common_8.2.0-1ubuntu23.10_amd64.deb 
sudo dpkg -i mysql-cluster-community-client-plugins_8.2.0-1ubuntu23.10_amd64.deb
sudo dpkg -i mysql-cluster-community-client-core_8.2.0-1ubuntu23.10_amd64.deb
sudo dpkg -i mysql-cluster-community-client_8.2.0-1ubuntu23.10_amd64.deb 
sudo dpkg -i mysql-client_8.2.0-1ubuntu23.10_amd64.deb 
sudo dpkg -i mysql-cluster-community-server-core_8.2.0-1ubuntu23.10_amd64.deb
sudo dpkg -i mysql-cluster-community-server_8.2.0-1ubuntu23.10_amd64.deb 
sudo dpkg -i mysql-server_8.2.0-1ubuntu23.10_amd64.deb
echo "Finished Installing Packages and Dependancies."

echo "Creating Config Files."
cp $MYSQL_CONFIG_FILE /etc/mysql/my.cnf

echo "Restarting MySQL."
sudo service mysql restart





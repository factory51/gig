# Task 2

## Task

Propose a series of steps for VM created in Task 1 to make the environment highly available.

## Solution

The proposed solution to move the Database created for Task 1, is the creation of a MySQL NDB Cluster.


### Setup Notes

4 Ubuntu 23.10 x64 servers have been provisioned, their roles and details are noted in the table below.


| Server Type | Public IP      | Private IP     | Node Id |
| :---------- | :------------- | :---------     | :------ |
| Cluster Management  | 165.232.90.202 | 10.133.59.159  | 1       |
| Data Node 1  | 206.189.11.93 | 10.133.59.157  | 2      |
| Data Node 2  | 165.232.84.221 | 10.133.59.158  | 3       |
| SQL Node 1 | 164.90.202.38 | 10.133.59.160 | 4       |
| SQL Node 2 | 206.189.8.141| 10.133.59.163 | 5       |


### 1 - Setup Management Node

Identifiy URL for NDB Management Server *.deb file for OS version from Mysql website:-
```https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster-community-management-server_8.2.0-1ubuntu23.10_amd64.deb```


Now logon to Management server and proceed to install

Update and Upgrade the new Image. Note, even with the upgrade command being set to answer yes, user input could still be needed if packages need upgrading, upgrade all if prompted.


```
sudo apt-get -y update # Update Image Packages
sudo apt-get -y upgrade # Upgrade Image Packages
```

Download the required package for NDB Management Server and install.

```
sudo mkdir /tmp/downloads && sudo chown nobody:nogroup /tmp/downloads && cd /tmp/downloads # create dir to hold downloaded files and switch

sudo curl -sSLO https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster-community-management-server_8.2.0-1ubuntu23.10_amd64.deb # Download NDB Cluster Server *.deb file

sudo dpkg -i mysql-cluster-community-management-server_8.2.0-1ubuntu23.10_amd64.deb # Install the cluster package.

```

Create directory for the cluster log/config files and create config file

```
sudo mkdir /var/lib/mysql-cluster/ # create folder for cluster files
sudo nano  /var/lib/mysql-cluster/config.ini # Now create a config file
```

Config File:- 

```
# Default settings
[ndbd default]
NoOfReplicas=2 # num nodes we have in cluster - here only 2

# Management node
[ndb_mgmd]
hostname=10.133.59.159 # Private IP of management server
datadir=/var/lib/mysql-cluster # path to newly created folder

# 1st data node
[ndbd]
hostname=10.133.59.157 # Private IP of Data Node 1
NodeId=2
datadir=/usr/local/mysql/data # mysql data directory created on node

# 2nd data node
[ndbd]
hostname=10.133.59.158 # Private IP of Data Node 2 
NodeId=3        
datadir=/usr/local/mysql/data # mysql data directory created on node

# SQL node 1
[mysqld]
hostname=10.133.59.160 # Private IP of SQL Node 1

# SQL node 2
[mysqld]
hostname=10.133.59.163 # Private IP of SQL Node 2

```

Save and exit.

Now start the management service and specifiy a link to newly created config file

```
sudo ndb_mgmd -f /var/lib/mysql-cluster/config.ini
```

Now add config to allow Cluster to run on boot.

```
sudo pkill -f ndb_mgmd # Stop it running for the moment
```

Create a systemd configuration file 

```
sudo nano /etc/systemd/system/ndb_mgmd.service
```

File:- 

```
[Unit]
Description=MySQL NDB Cluster Management Server
After=network.target auditd.service

[Service]
Type=forking
ExecStart=/usr/sbin/ndb_mgmd -f /var/lib/mysql-cluster/config.ini
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target

```

Save and exit.

Now reload systemd manager, enable and start the management cluster and check status

```
sudo systemctl daemon-reload # reload
sudo systemctl enable ndb_mgmd # enable
sudo systemctl start ndb_mgmd # start
sudo systemctl status ndb_mgmd # check
```

The output of the status check should show the management cluster manager is now running

```
● ndb_mgmd.service - MySQL NDB Cluster Management Server
     Loaded: loaded (/etc/systemd/system/ndb_mgmd.service; enabled; preset: enabled)
     Active: active (running) since Sun 2023-11-19 10:00:07 UTC; 6s ago
    Process: 4115 ExecStart=/usr/sbin/ndb_mgmd -f /var/lib/mysql-cluster/config.ini (code=exited, status=0/SUCCESS)
   Main PID: 4116 (ndb_mgmd)
      Tasks: 12 (limit: 1101)
     Memory: 2.6M
        CPU: 130ms
     CGroup: /system.slice/ndb_mgmd.service
             └─4116 /usr/sbin/ndb_mgmd -f /var/lib/mysql-cluster/config.ini

Nov 19 10:00:07 gig-task3-mgmt systemd[1]: Starting ndb_mgmd.service - MySQL NDB Cluster Management Server...
Nov 19 10:00:07 gig-task3-mgmt ndb_mgmd[4115]: Failed to open /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list: No such file or directory
Nov 19 10:00:07 gig-task3-mgmt ndb_mgmd[4115]: MySQL Cluster Management Server mysql-8.2.0 ndb-8.2.0
Nov 19 10:00:07 gig-task3-mgmt systemd[1]: Started ndb_mgmd.service - MySQL NDB Cluster Management Server.
```

### 2 - Setup Data nodes

Identifiy URL for NDB Data Node *.deb file for OS version from Mysql website:-
```https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster-community-data-node_8.2.0-1ubuntu23.10_amd64.deb```

Now logon to the data nodes and configure. Perform all steps on both servers

```
sudo apt-get -y update # Update Image Packages
sudo apt-get -y upgrade # Upgrade Image Packages
```


Download the required package for NDB Data Node and install.

```
sudo mkdir /tmp/downloads && sudo chown nobody:nogroup /tmp/downloads && cd /tmp/downloads # create dir to hold downloaded files and switch

sudo curl -sSLO https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster-community-data-node_8.2.0-1ubuntu23.10_amd64.deb # Download NDB Data Node *.deb file

sudo apt-get -y install libclass-methodmaker-perl # Install a required dependancy

sudo dpkg -i mysql-cluster-community-data-node_8.2.0-1ubuntu23.10_amd64.deb # Install the data node package.

```

Now edit mysql config file to connect to the management node

```
sudo nano /etc/my.cnf
```

Add following to the file

```
[mysql_cluster]
ndb-connectstring=10.133.59.159 # private Ip of management server
```

Create the mysql data folder we indicated in the management server config

```
sudo mkdir -p /usr/local/mysql/data
```

Start the data node

```
ndbd
```

This should give the below output

```
2023-11-19 10:24:00 [ndbd] INFO     -- Angel connected to '10.133.59.159:1186' # Private IP of Management Cluster
2023-11-19 10:24:00 [ndbd] INFO     -- Angel allocated nodeid: 2 # Node ID of data node you're configuring
```

Now add the config to run data node on boot

```
sudo pkill -f ndbd # stop data node

```

Create a systemd configuration file

```
sudo nano /etc/systemd/system/ndbd.service
```

File:- 

```
[Unit]
Description=MySQL NDB Data Node Daemon
After=network.target auditd.service

[Service]
Type=forking
ExecStart=/usr/sbin/ndbd
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target

```

Save and exit.

Now reload systemd manager, enable and start the management cluster and check status

```
sudo systemctl daemon-reload # reload
sudo systemctl enable ndbd # enable
sudo systemctl start ndbd # start
sudo systemctl status ndbd # check

```

The output of the check should show that its running

```
● ndbd.service - MySQL NDB Data Node Daemon
     Loaded: loaded (/etc/systemd/system/ndbd.service; enabled; preset: enabled)
     Active: active (running) since Sun 2023-11-19 10:33:57 UTC; 297ms ago
    Process: 5752 ExecStart=/usr/sbin/ndbd (code=exited, status=0/SUCCESS)
   Main PID: 5753 (ndbd)
      Tasks: 4 (limit: 1101)
     Memory: 213.5M
        CPU: 172ms
     CGroup: /system.slice/ndbd.service
             ├─5753 /usr/sbin/ndbd
             └─5754 /usr/sbin/ndbd

Nov 19 10:33:57 gig-task3-data-01 systemd[1]: Starting ndbd.service - MySQL NDB Data Node Daemon...
Nov 19 10:33:57 gig-task3-data-01 ndbd[5752]: Failed to open /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list: No such file or directory
Nov 19 10:33:57 gig-task3-data-01 ndbd[5752]: 2023-11-19 10:33:57 [ndbd] INFO     -- Angel connected to '10.133.59.159:1186'
Nov 19 10:33:57 gig-task3-data-01 ndbd[5752]: 2023-11-19 10:33:57 [ndbd] INFO     -- Angel allocated nodeid: 2
Nov 19 10:33:57 gig-task3-data-01 systemd[1]: Started ndbd.service - MySQL NDB Data Node Daemon.
```

### 3 - Setup SQL Nodes

Identifiy URL for Mysql Cluster archive file for OS version from Mysql website:-
```https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster_8.2.0-1ubuntu23.10_amd64.deb-bundle.tar```


Update 
```
sudo apt-get -y update # Update Image Packages
sudo apt-get -y upgrade # Upgrade Image Packages
```



Download, unpack  

```
sudo mkdir /tmp/downloads && sudo chown nobody:nogroup /tmp/downloads && cd /tmp/downloads # create dir to hold downloaded files and switch
sudo mkdir /tmp/install && sudo chown nobody:nogroup /tmp/install # create directory to hold installable *.debs
sudo curl -sSLO https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.2/mysql-cluster_8.2.0-1ubuntu23.10_amd64.deb-bundle.tar # Download NDB Cluster Server *.deb file
sudo tar -xvf mysql-cluster_8.2.0-1ubuntu23.10_amd64.deb-bundle.tar -C ../install/
cd ../install
```

Now install - you will be prompted to setup a mysql root password. 

```
cd ../install
sudo apt-get -y install libmecab2 # needed for mysql-cluster-community-server-core_8.2.0-1ubuntu23.10_amd64.deb
sudo dpkg -i mysql-common_8.2.0-1ubuntu23.10_amd64.deb #
sudo dpkg -i mysql-cluster-community-client-plugins_8.2.0-1ubuntu23.10_amd64.deb
sudo dpkg -i mysql-cluster-community-client-core_8.2.0-1ubuntu23.10_amd64.deb
sudo dpkg -i mysql-cluster-community-client_8.2.0-1ubuntu23.10_amd64.deb #
sudo dpkg -i mysql-client_8.2.0-1ubuntu23.10_amd64.deb #
sudo dpkg -i mysql-cluster-community-server-core_8.2.0-1ubuntu23.10_amd64.deb
sudo dpkg -i mysql-cluster-community-server_8.2.0-1ubuntu23.10_amd64.deb #
sudo dpkg -i mysql-server_8.2.0-1ubuntu23.10_amd64.deb #
```

Now edit mysql config to use NDB Cluster setup

```
sudo nano /etc/mysql/my.cnf
```

Add the following just before the Include paths

```
[mysqld]
ndbcluster
[mysql_cluster]
ndb-connectstring=10.133.59.159 # private ip address of the cluster manager
```

Save and exit.

Restart the Mysql server to affect changes and login!

```
sudo service mysql restart
mysql -u root -p
```

Login to Mysql to check its working 

```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.2.0-cluster MySQL Cluster Community Server - GPL

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

```

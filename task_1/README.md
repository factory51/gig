# TASK 1

A MySQL a Master - Replica setup was implemented to meet the criteria of Task 1. 

## Server Setup for the Task

Two servers running clean images of Ubuntu 23.10 x64 where provisioned for the task, their details are below:- 

| Server Type | Public IP      | Private IP     | Node Id | Purpose |
| :---------- | :------------- | :---------     | :------ | :------ |
| Primary  | 206.189.106.237 | 10.133.59.162  | 1       | Primary |
| Data Node 1  | 206.189.108.74| 10.133.59.161  | 2      | Replica |


## Script details
The installation scripts can be found in:- 

```
task_1/primary/primary-setup.sh
task_1/replica/replica-setup.sh
```

These files need to be executable by the user account running them, eg

```
sudo chmod +x task_1/primary/primary-setup.sh
sudo chmod +x task_1/replica/replica-setup.sh
```



## Modifying Config to reflect local enviroment

The config that will need to be changed for Primary setup is in `task_1/primary/primary-setup.sh` and should reflect your local setup.

```
PRIMARY_IP="206.189.106.237" # [CHANGE] PRIMARY NODE IP
REPLICA_IP="206.189.108.74" [CHANGE] REPLCIA NODE IP
MYSQL_CONFIG_FILE="primary.mysql.conf" # OUR PREPPED CONFIG
MYSQL="/usr/bin/mysql" # PATH TO MYSQL (CRONTAB SAFE)
MYSQL_USER="notroot" # [CHANGE] To Reflect MySQL Account in use for running script
MYSQL_PASS="notpassword" # [CHANGE] To Reflect MySQL Account in use for running script
MYSQL_PORT=5566
REPLICA_USERNAME="replica" # [CHANGE] TO desried replcia username
REPLICA_PASSWORD="replication_password" # [CHANGE] To desried replcia password
```

The config that will need to be changed for Primary setup is in `task_1/replica/replica-setup.sh` and should reflect your local setup.

```
PRIMARY_IP="206.189.106.237" # [CHANGE] PRIMARY NODE IP
REPLICA_IP="206.189.108.74" [CHANGE] REPLCIA NODE IP
MYSQL_CONFIG_FILE="replica.mysql.conf" # OUR PREPPED CONFIG
MYSQL="/usr/bin/mysql" # PATH TO MYSQL (CRONTAB SAFE)
MYSQL_USER="notroot" # [CHANGE] To Reflect MySQL Account in use for running script
MYSQL_PASS="notpassword" # [CHANGE] To Reflect MySQL Account in use for running script
MYSQL_PORT=5566
REPLICA_USERNAME="replica" # [CHANGE] TO specified replcia username
REPLICA_PASSWORD="replication_password" # [CHANGE] To specified replcia password

```

## Running Setup Script

### Primary

Switch to the directory containing `primary-setup.sh`

#### Usage
```
sudo ./primary-setup.sh
```

Upon completion the script will notify the user of the binlog file name and the position in the binlog for use setting up the Replica node, eg:- 

```
MySQL Log file for Replica setup: 
binlog-000034.log
MySQL Position for Replica setup:
692
```

Make a note of these to use in Replica setup.

### Replica

Switch to the directory containing `replica-setup.sh`

#### Usage
```
sudo ./replica-setup.sh --file binlog-000034.log --position 692
```

## User Account Creation
 Two helper utility scripts have been created to facilitate the creation of the account required in Task 1. They are located:- 

 ```
 task_1/utils/create-fullaccess-user.sh
 task_1/utils/create-readonly-user.sh
 ```

 Make sure these files need are executable by the user account running them, eg

```
sudo chmod +x task_1/utils/create-fullaccess-user.sh
sudo chmod +x task_1/utils/create-readonly-user.sh
```

Both file use the same command line arguments to run
```
--mysql_username # the username of your mysql account creating the user
--mysql_password # the above accounts password
--new_user # the new user to create
--new_password # the password for the new account
```

### Usage

```
./create-fullaccess-user.sh --mysql_username admin --mysql_password password --new_user testadmin --new_password password1 --database example

./create-readonly-user.sh --mysql_username admin --mysql_password password --new_user testuser1 --new_password password1 --database example
```


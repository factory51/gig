# Task 1

## Task

Setup a VM Enviroment for a web application running on port `5566` with an expected load of 50,000 app users.

## Solution

A Master-Slave configuration, with the application only writing to the Master Node [Primary] and only reading from the Slave node(s) [Replica(s)].

### Setup Notes

2 Ubuntu 23.10 x64 servers have been provisioned for this, their roles and details and noted below.

| Server Type | Public IP      | Private IP     | Node Id | Purpose |
| :---------- | :------------- | :---------     | :------ | :------ |
| Primary  | 206.189.106.237 | 10.133.59.162  | 1       | Write |
| Data Node 1  | 206.189.108.74| 10.133.59.161  | 2      | Read |


# 1 - Setup mysql on Primary and Replica node(s)

```
sudo apt-get -y update # update packages 
sudo apt-get -y install mysql-server #use supplied package to install mysql

```

Enable MySQL on all nodes

```
sudo systemctl start mysql
```

Secure mysql installation, this **should** prompt for a mysql root password. Set seperate passwords for each node for security. Requested answer selections below

```
mysql_secure_installation

Would you like to setup VALIDATE PASSWORD component?
Answer y to all options. n # No needed
Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y

```

**Note**: `mysql_secure_installation` on the images used didn't prompt for setting a root password. Manually set a root password if needed:- 

Login to MySQL

```
mysql -u root 
```

Perform

```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'PASSWORD_GOES_HERE';
FLUSH PRIVILEGES;
```

## 2 - Configure the Primary [Primary only]

Backup and edit the `mysqld.cnf` file to reflect our needed settings.

```
sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.orig
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```

Add following setting to `mysqld.cnf` under the `[mysqld] block`

```
#bind-address           = 127.0.0.1 # Should be commented out
#mysqlx-bind-address    = 127.0.0.1 # Should be commented out
port=5566 # should be uncommented and changed to reflect the port requirement
server-id = 1
log_bin = /var/log/mysql/mysql-bin.log

```

Restart MySQL so changes take affect

```
sudo service mysql restart
```

Now create a replication user on the master

```
mysql -u root -p

CREATE USER 'replica'@'206.189.108.74' IDENTIFIED WITH 'mysql_native_password' BY 'Som3p4ssw0rd$$';
GRANT REPLICATION SLAVE ON *.* TO 'replica'@'206.189.108.74';
```

Now check and make note of the bin log position for use on the replica node(s).

```
SHOW MASTER STATUS\G
```
Gives
```
*************************** 1. row ***************************
             File: mysql-bin.000034
         Position: 692
     Binlog_Do_DB:
 Binlog_Ignore_DB:
Executed_Gtid_Set:
1 row in set (0.00 sec)
```

## 3 - Configure the Replica(s)[Replica Only]

Backup and edit the `mysqld.cnf` file to reflect our needed settings.

```
sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.orig
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```

Add following setting to `mysqld.cnf` under the `[mysqld] block`

```
#bind-address           = 127.0.0.1 # Should be commented out
#mysqlx-bind-address    = 127.0.0.1 # Should be commented out
port=5566 # should be uncommented and changed to reflect the port requirement
server-id = 2
log_bin = /var/log/mysql/mysql-bin.log


```

Restart mysql so changes take affect.

```
sudo service mysql restart
```

Now connect the Replica to the Primary and start

```
mysql -u root -p

CHANGE MASTER TO MASTER_HOST='206.189.106.237', MASTER_PORT=5566, MASTER_USER='replica', MASTER_PASSWORD='Som3p4ssw0rd$$', MASTER_LOG_FILE='mysql-bin.000034', MASTER_LOG_POS=692;

START SLAVE;
```

Check the slave status to check everything is working

```
mysql> SHOW SLAVE STATUS\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for source to send event
                  Master_Host: 206.189.106.237
                  Master_User: replica
                  Master_Port: 5566
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000034
          Read_Master_Log_Pos: 692
               Relay_Log_File: gig-task1-replica-01-relay-bin.000002
                Relay_Log_Pos: 326
        Relay_Master_Log_File: mysql-bin.000034
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 692
              Relay_Log_Space: 551
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 0
               Last_SQL_Error:
  Replicate_Ignore_Server_Ids:
             Master_Server_Id: 1
                  Master_UUID: a1ada003-86d7-11ee-9727-ba44a1150999
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Replica has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind:
      Last_IO_Error_Timestamp:
     Last_SQL_Error_Timestamp:
               Master_SSL_Crl:
           Master_SSL_Crlpath:
           Retrieved_Gtid_Set:
            Executed_Gtid_Set:
                Auto_Position: 0
         Replicate_Rewrite_DB:
                 Channel_Name:
           Master_TLS_Version:
       Master_public_key_path:
        Get_master_public_key: 0
            Network_Namespace:
1 row in set, 1 warning (0.00 sec)
```

Now create an example database with a table and values on the Primary node and verify its replication to the replica correctly.

```
# on Primary Node
mysql -u root -p 

CREATE DATABASE task1;
use task1;
CREATE TABLE table1
(
    message VARCHAR(255) NOT NULL
);

INSERT INTO table1 VALUES("Hello World!");

# on Replica Node

mysql> SHOW DATABASES ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| task1              | <--- replicated across correctly
+--------------------+

SELECT * FROM task1.table1; #double check

mysql> SELECT * FROM task1.table1;
+--------------+
| message      |
+--------------+
| Hello World! |
+--------------+

```


## User Accounts

Group Admin accounts should be added to the Primary node

```
CREATE USER 'gigadmin'@'%' IDENTIFIED BY 'P$ssw0rd$';
GRANT ALL PRIVILEGES ON *.* TO 'gigadmin'@'%';
FLUSH PRIVILEGES;
```

Developer accounts can be added with read only permissions with the following

```
CREATE USER 'giguser_1'@'%' IDENTIFIED BY 'P$ssw0rd$';
GRANT SELECT ON task1.* TO 'giguser_1'@'%';
FLUSH PRIVILEGES;
```








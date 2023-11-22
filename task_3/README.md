# Task 3

Database creation and initial data spawn for the database required in Task 3.

## Installation Details

The files needed to create the database can be located in:- 

```
task_3/task_3_structure.sql
task_3/task_3_test_data.sql
```

To install the database and populate switch to the directory containing the sql files and run:- 

```
mysql -u USERNAME -pPASSWORD < task_3_structure.sql
mysql -u USERNAME -pPASSWORD < task_3_test_data.sql
```

## Requirements

Below is an explination of how the database handles the requirements indicated in the task.

### Manage Users

- A generic user table was created to hold all users who will log into the application and use its services.


```
+------------------+------------------+------+-----+---------+----------------+
| Field            | Type             | Null | Key | Default | Extra          |
+------------------+------------------+------+-----+---------+----------------+
| user_id          | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| username         | varchar(64)      | NO   |     | NULL    |                |
| created_at       | datetime         | NO   |     | NULL    |                |
| created_user_id  | int(11)          | NO   |     | NULL    |                |
| modified_at      | datetime         | YES  |     | NULL    |                |
| modified_user_id | int(11)          | YES  |     | NULL    |                |
| status           | tinyint(4)       | NO   |     | NULL    |                |
+------------------+------------------+------+-----+---------+----------------+
```

- A user password table was created to remove the password hash from the users table, it also allows for multiple entires with a status of is_active. If the application doesn't want to allow users to re-use passwords, this can be used to compare the older stored hashes against new input.

```
+-------------+------------+------+-----+---------+----------------+
| Field       | Type       | Null | Key | Default | Extra          |
+-------------+------------+------+-----+---------+----------------+
| password_id | int(11)    | NO   | PRI | NULL    | auto_increment |
| user_id     | int(11)    | NO   | MUL | NULL    |                |
| password    | char(60)   | NO   |     | NULL    |                |
| salt        | char(16)   | NO   |     | NULL    |                |
| created_at  | datetime   | NO   |     | NULL    |                |
| replaced_at | datetime   | YES  |     | NULL    |                |
| is_active   | tinyint(4) | NO   |     | NULL    |                |
+-------------+------------+------+-----+---------+----------------+
```

- User Types were created that apply to all user accounts inside the database.

```
+------------------+-------------+------+-----+---------+----------------+
| Field            | Type        | Null | Key | Default | Extra          |
+------------------+-------------+------+-----+---------+----------------+
| user_type_id     | int(11)     | NO   | PRI | NULL    | auto_increment |
| description      | varchar(64) | NO   |     | NULL    |                |
| label            | varchar(64) | NO   |     | NULL    |                |
| created_at       | datetime    | NO   |     | NULL    |                |
| created_user_id  | int(11)     | NO   |     | NULL    |                |
| modified_at      | datetime    | YES  |     | NULL    |                |
| modified_user_id | int(11)     | YES  |     | NULL    |                |
| is_active        | tinyint(4)  | YES  |     | NULL    |                |
+------------------+-------------+------+-----+---------+----------------+
```

- User Type Lookup `user_type_lookup` was created to assign a user a type.

```
+---------+--------------+
| user_id | user_type_id |
+---------+--------------+
|       1 |            1 |
|       2 |            2 |
|       3 |            2 |
|       4 |            3 |
|       5 |            3 |
|       6 |            3 |
|       7 |            4 |
|       8 |            4 |
|       9 |            4 |
|      10 |            4 |
+---------+--------------+
```

#### Example Authenticate Query

**Note**: No hashing is being performed in this example query, and the UUID that was inserted upon user creation was manually taken from the database.

```
SELECT COUNT(1) has_access FROM user_passwords up INNER JOIN users u ON u.user_id = up.password_id AND up.is_active=1 WHERE u.username='superadmin1' AND up.password='f31a96ba-891d-11ee-80ac-acde48001122';

```

### User Access Control

Access control was modelled around the application and CRUD. And assuming the application logic takes care of access control from the end user. Also ACL is based on user type `user_type_id`

- Each possible action was recorded in a table `application_actions` with an identifier

```
+-----------+-------------+-----------------------------+
| action_id | http_method | description                 |
+-----------+-------------+-----------------------------+
|         1 | GET         | Read Data Access - HTTP GET |
|         2 | CREATE      | Write Access - HTTP POST    |
|         3 | UPDATE      | Write Access - HTTP PUT     |
|         4 | DELETE      | Write Access - HTTP DELETE  |
+-----------+-------------+-----------------------------+
```

- Example endpoints were added to the database in the table `application_endpoints` they mimic pages on application were user could interact with the database.

```
+-------------+-------------------------------+-------------------------+
| endpoint_id | description                   | route                   |
+-------------+-------------------------------+-------------------------+
|           1 | Home Page                     | /                       |
|           2 | Web Registration Page         | /signup                 |
|           3 | Web Orders                    | /orders                 |
|           4 | Web View Band details         | /view/bands             |
|           5 | Web View Performer details    | /view/performers        |
|           6 | Web View Achievements details | /view/achievements      |
|           7 | Admin Home Page               | /admin/                 |
|           8 | Admin Settings                | /admin/settings         |
|           9 | Admin User Management         | /admin/users/management |
+-------------+-------------------------------+-------------------------+
```

- Each and every action available for a users type on a particular endpoint are recorded in the table `user_type_endpoint_actions`

#### Example finding user_type_permission query
```
select * from user_type_endpoint_actions where user_type_id = 1 ;
```

### Manage Bands / Tracks / Performers / Achievements

Several assumptions where made when creating the structure to store information relating to music in general

- An album can either belong to a band (multiple members), to a solo artist, or can be a compliation of 
multiple unrelated tracks by various artists, this is represented in the table `album_types`.

```
+---------------+-------------------+
| album_type_id | label             |
+---------------+-------------------+
|             1 | Band Album        |
|             2 | Solo Artist Album |
|             3 | Compilation Album |
+---------------+-------------------+
```

- An album can belong to different record companies modelled by `record_labels`
```
+-----------------+------------------+
| record_label_id | label            |
+-----------------+------------------+
|               1 | United Artists   |
|               2 | Geffen           |
|               3 | RCA              |
|               4 | Hospital Records |
|               5 | Factory Records  |
+-----------------+------------------+
```

- Albums are recorded in the table `albums`, noting what type of album they are and which record label they belong to.

```
+----------+---------------+----------------------------+
| album_id | album_type_id | label                      |
+----------+---------------+----------------------------+
|        1 |             1 | Kill Em All                |
|        2 |             1 | Ride The Lightening        |
|        3 |             1 | And Jusitice for All       |
|        4 |             1 | Metallica                  |
|        5 |             1 | Welcome to Sky Valley      |
|        6 |             1 | Blues for the Red Sun      |
|        7 |             1 | Queens of the Stone Age    |
|        8 |             1 | Rated R                    |
|        9 |             1 | Songs for the Deaf         |
|       10 |             2 | Wreck of the Day           |
|       11 |             2 | Broken Dolls & Odds & Ends |
+----------+---------------+----------------------------+

```


- An album is composed of multiple tracks, this is modlled in `album_track_listing`.

```
+----------+----------+-------+
| album_id | track_id | order |
+----------+----------+-------+
|        1 |        1 |     1 |
|        1 |        2 |     2 |
+----------+----------+-------+
```

- Tracks are recorded in the table `tracks`

```
+----------+-------------------+
| track_id | label             |
+----------+-------------------+
|        1 | Hit the Lights    |
|        2 | The Four Horsemen |
|        3 | Creeping Death    |
|        4 | Fade to Black     |
+----------+-------------------+
```

- Tracks can have multiple performers and even performers that aren't generally associated with the band (if its a band album), this is modelled in `track_performer_rosta`.

```
+----------+--------------+
| track_id | performer_id |
+----------+--------------+
|        1 |            1 |
|        1 |            2 |
|        1 |            5 |
|        1 |            6 |
|        2 |            1 |
|        2 |            2 |
|        2 |            5 |
|        2 |            6 |
|        3 |            1 |
|        3 |            2 |
|        3 |            4 |
|        3 |            7 |
+----------+--------------+
```

- Performers can be in multiple bands so have been abstracted away from a specific relation with a band, they exist as performers in their own right, this is detailed in `performers`.

```
+--------------+--------------------+
| performer_id | label              |
+--------------+--------------------+
|            1 | Lars Ulrich        |
|            2 | James Hetfield     |
|            3 | Robert Trujillo    |
|            4 | Kurt Hammet        |
|            5 | Cliff Burton       |
|            6 | Dave Mustaine      |
|            7 | Jason Newsted      |
|            8 | Josh Homme         |
|            9 | John Garcia        |
|           10 | Nick Oliveri       |
|           11 | Brant Bjork        |
|           12 | Scott Reeder       |
|           13 | Alfredo Hernández  |
|           14 | Dave Grohl         |
|           15 | Mark Lanegan       |
|           16 | Michael Shuman     |
|           17 | Troy Van Leeuwen   |
|           18 | Anna Nalik         |
+--------------+--------------------+
```

- Performer details are saved against a specified input schema, in key/value pair from in the table `performer_details`.

```
+--------------+------------+------------+
| performer_id | key        | value      |
+--------------+------------+------------+
|            1 | first_name | Lars       |
|            1 | last_name  | Ulrich     |
|            1 | age        | 59         |
|            1 | from       | Hellerup   |
|            2 | first_name | James      |
|            2 | last_name  | Hetfield   |
|            2 | age        | 59         |
|            2 | from       | California |
|            3 | first_name | Robert     |
|            3 | last_name  | Trujillo   |
|            3 | age        | 45         |
|            3 | from       | California |
|            4 | first_name | Kurt       |
|            4 | last_name  | Hammet     |
|            4 | age        | 56         |
|            4 | from       | New York   |
|           18 | first_name | Anna       |
|           18 | last_name  | Nalik      |
|           18 | age        | 38         |
|           18 | from       | California |
+--------------+------------+------------+
```

- Tracks exist as their own entities inside the `tracks` table but are related to a record label

```
+----------+-----------------+-----------------------------+
| track_id | record_label_id | label                       |
+----------+-----------------+-----------------------------+
|        1 |               3 | Hit the Lights              |
|        2 |               3 | The Four Horsemen           |
|        3 |               3 | Creeping Death              |
|        4 |               3 | Fade to Black               |
|        5 |               3 | Eye of the Beholder         |
|        6 |               3 | One                         |
|        7 |               3 | Enter Sandman               |
|        8 |               3 | Dont tread on me            |
|        9 |               1 | Asteroid                    |
|       10 |               1 | Demon Cleaner               |
|       11 |               4 | Feel Good Hit of the Summer |
|       12 |               2 | 2am (Breathe)               |
+----------+-----------------+-----------------------------+
```

- Each track has a rosta of performers, to model how performers move around bands over time, this is modelled by `track_performer_rosta`.

```
+----------+--------------+----------------+
| track_id | performer_id | label          |
+----------+--------------+----------------+
|        1 |            1 | Lars Ulrich    |
|        1 |            2 | James Hetfield |
|        1 |            5 | Cliff Burton   |
|        1 |            6 | Dave Mustaine  |
+----------+--------------+----------------+
```

- Awards belong to an over arching body that issues the award, this is mimiced by the table `award_body`

```
+---------------+-------------+
| award_body_id | label       |
+---------------+-------------+
|             1 | Grammys     |
|             2 | Brit Awards |
|             3 | Tony Awards |
|             4 | MTV Awards  |
+---------------+-------------+
```

- Awards have types to indicate if they are for a band/group or a solo performer, this is reflected in `award_types`

```
+---------------+------------------+
| award_type_id | label            |
+---------------+------------------+
|             1 | Group Award      |
|             2 | Individual Award |
+---------------+------------------+
```

- Available awards for each award body and award type is modeled in `awards`.

```
+----------+---------------+------------------------------------+
| award_id | award_type_id | label                              |
+----------+---------------+------------------------------------+
|        1 |             1 | Best New Comers                    |
|        2 |             2 | Best New Comer                     |
|        3 |             1 | Best Album                         |
|        4 |             2 | Best Album by a Female Solo Artist |
+----------+---------------+------------------------------------+
```

- Awards are listed in an ongoing record log `awards_listing` as awards are issued multiple times

```
+------------------+---------------+----------+----------------------------+
| award_listing_id | award_body_id | award_id | label                      |
+------------------+---------------+----------+----------------------------+
|                1 |             1 |        1 | Best New Commer - Grammy   |
|                2 |             1 |        2 | Best New Commer - Grammy   |
|                3 |             1 |        3 | Best Album - Grammy        |
|                4 |             1 |        4 | Best Female Album - Grammy |
+------------------+---------------+----------+----------------------------+
```

- Finally performers are listed against a particular award in `award_listing_performer_rosta`, which records if they won or not.

```
+------------------+--------------+----------------+----------------+--------+
| award_listing_id | performer_id | label          | nominated_date | winner |
+------------------+--------------+----------------+----------------+--------+
|                1 |            1 | Lars Ulrich    | 2023-11-22     |      1 |
|                1 |            2 | James Hetfield | 2023-11-22     |      1 |
|                1 |            5 | Cliff Burton   | 2023-11-22     |      1 |
|                1 |            6 | Dave Mustaine  | 2023-11-22     |      1 |
|                2 |           12 | Anna Nalik     | 2023-11-22     |      1 |
|                3 |            1 | Lars Ulrich    | 2023-11-22     |      0 |
|                3 |            2 | James Hetfield | 2023-11-22     |      0 |
|                3 |            5 | Cliff Burton   | 2023-11-22     |      0 |
|                3 |            6 | Dave Mustaine  | 2023-11-22     |      0 |
|                4 |           12 | Anna Nalik     | 2023-11-22     |      1 |
+------------------+--------------+----------------+----------------+--------+
```

### Manage Orders

- Order status are modelled in the table `order_status`.

```
+-----------------+------------------------+
| order_status_id | label                  |
+-----------------+------------------------+
|               1 | Order Processsing      |
|               2 | Order Payment Declined |
|               3 | Order Dispatched       |
|               4 | Order Cancelled        |
|               5 | Order Complete         |
+-----------------+------------------------+

```

- User Orders are recored in the table `orders`.

```
+----------+---------+--------+
| order_id | user_id | amount |
+----------+---------+--------+
|        1 |       8 |   3499 |
|        2 |       9 |   1999 |
|        3 |      10 |   2134 |
|        4 |       7 |    299 |
|        5 |       8 |    999 |
+----------+---------+--------+

```

- An orders ongoing status is recorded in `order_history`

```
+----------+-----------------+
| order_id | order_status_id |
+----------+-----------------+
|        1 |               1 |
|        1 |               3 |
|        1 |               5 |
+----------+-----------------+
```


- Orders items have a specific type, this is modelled in `item_types`, it indicates if the user is buying an ablum or a track on its own.

```
+--------------+------------------+
| item_type_id | label            |
+--------------+------------------+
|            1 | Full Album       |
|            2 | Individual Track |
+--------------+------------------+
```

- Finally the items a user has attached to a specific order are recorded in `order_items`

```
+----------+--------------+---------+
| order_id | item_type_id | item_id |
+----------+--------------+---------+
|        3 |            1 |       9 |
|        3 |            2 |       1 |
|        3 |            2 |       9 |
|        3 |            2 |      11 |
+----------+--------------+---------+
```
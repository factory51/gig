#! /bin/bash

# User input block

NEW_USERNAME="" # user account to create 
NEW_PASSWORD="" # password for account

MYSQL_USER="" # This instance mysql user name
MYSQL_PASS="" # This instance mysql password

# script definition block
MYSQL="/usr/bin/mysql"

function show_usage {
  echo "Usage: $0 --mysql_username <mysql user> --mysql_password <mysql password> --new_user <new user username> --new_password <new user passowrd> --database <which database to assign new user to>"
  exit 1
}

# Parse command-line parameters
while [[ $# -gt 0 ]]; do
    case "$1" in
        --mysql_username)
            MYSQL_USERNAME=$2
            shift 2
            ;;
        --mysql_password)
            MYSQL_PASSWORD=$2
            shift 2
            ;;
        --new_user)
            NEW_USERNAME=$2
            shift 2
            ;;
        --new_password)
            NEW_PASSWORD=$2
            shift 2
            ;;
        --database)
            DATABASE=$2
            shift 2
            ;;
        *)
            show_usage
            ;;
    esac
done

    if [ -z "$MYSQL_USERNAME" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$NEW_USERNAME" ] || [ -z "$NEW_PASSWORD" ] || [ -z "$DATABASE" ]; then
    show_usage
fi


# Create MySQL user with read-only permissions
echo "Creating MySQL user with read-only permissions..."
$MYSQL -u "$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" -e "CREATE USER '$NEW_USERNAME'@'%' IDENTIFIED BY '$NEW_PASSWORD';" 2>/dev/null
$MYSQL -u "$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" -e "GRANT SELECT ON $DATABASE.* TO '$NEW_USERNAME'@'%';" 2>/dev/null
$MYSQL -u "$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" -e "FLUSH PRIVILEGES;" 2>/dev/null

echo "MySQL user '$NEW_USERNAME' created with read-only permissions for database '$DATABASE'."




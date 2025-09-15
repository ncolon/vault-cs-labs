#!/bin/sh

# Note: This script requires that the VAULT_ADDR, VAULT_TOKEN, and MYSQL_ENDPOINT environment variables be set.
# Example:
# export VAULT_ADDR=http://localhost:8200
# export VAULT_TOKEN=root
# export MYSQL_ENDPOINT=localhost:3306

# Enable the database secrets engine
vault secrets enable -path=lob_a/workshop/database database

# Configure the database secrets engine to talk to MySQL
vault write lob_a/workshop/database/config/wsmysqldatabase \
    plugin_name=mysql-database-plugin \
    connection_url="{{username}}:{{password}}@tcp(${MYSQL_ENDPOINT})/" \
    allowed_roles="workshop-app","workshop-app-long" \
    username="hashicorp" \
    password="Password123"

# Rotate root password
vault write -force lob_a/workshop/database/rotate-root/wsmysqldatabase

# Create a role with a longer TTL
vault write lob_a/workshop/database/roles/workshop-app-long \
    db_name=wsmysqldatabase \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON my_app.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="24h"

# Create a role with a shorter TTL
vault write lob_a/workshop/database/roles/workshop-app \
    db_name=wsmysqldatabase \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON my_app.* TO '{{name}}'@'%';" \
    default_ttl="3m" \
    max_ttl="6m"

echo "Script complete."
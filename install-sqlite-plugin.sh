#!/bin/bash

# Download and unzip the SQLite plugin
curl -O https://downloads.wordpress.org/plugin/sqlite-database-integration.zip
unzip -q -o sqlite-database-integration.zip -d /var/www/html/wp-content/plugins/

# Set correct ownership
chown -R www-data:www-data /var/www/html/wp-content/plugins/sqlite-database-integration

cp -p /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy /var/www/html/wp-content/db.php

# Cleanup
rm sqlite-database-integration.zip

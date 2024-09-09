#!/bin/bash

# Download and unzip the SQLite plugin
echo "checking if sqlite plugin is installed"
if [ ! -d /var/www/html/wp-content/plugins/sqlite-database-integration ]; then
  echo "sqlite plugin not installed, installing now"
  curl -O https://downloads.wordpress.org/plugin/sqlite-database-integration.zip &&
    unzip sqlite-database-integration.zip -d /var/www/html/wp-content/plugins/ &&
    chown -R www-data:www-data /var/www/html/wp-content/plugins/sqlite-database-integration &&
    cp -p /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy /var/www/html/wp-content/db.php &&
    rm sqlite-database-integration.zip
fi

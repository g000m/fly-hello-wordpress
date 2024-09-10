#!/bin/bash
set -e

# Download and extract the SQLite plugin, set correct ownership, clean up in one step
curl -O https://downloads.wordpress.org/plugin/sqlite-database-integration.zip \
  && tar -xf sqlite-database-integration.zip -C /var/www/html/wp-content/plugins/ \
  && chown -R www-data:www-data /var/www/html/wp-content/plugins/sqlite-database-integration \
  && cp -p /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy /var/www/html/wp-content/db.php \
  && rm sqlite-database-integration.zip

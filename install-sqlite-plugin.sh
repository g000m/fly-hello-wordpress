#!/bin/bash
# This script will handle plugin installation
curl -O https://downloads.wordpress.org/plugin/sqlite-database-integration.zip
unzip sqlite-database-integration.zip -d /var/www/html/wp-content/plugins/
chown -R www-data:www-data /var/www/html/wp-content/plugins/sqlite-database-integration

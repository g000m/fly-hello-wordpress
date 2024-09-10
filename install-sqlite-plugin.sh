#!/bin/bash

set -e

# Ensure necessary tools are installed
if ! command -v curl &> /dev/null || ! command -v unzip &> /dev/null; then
  echo "curl and unzip are required but not installed. Exiting." >&2
  exit 1
fi

echo "checking if sqlite plugin is installed"
if [ ! -d /var/www/html/wp-content/plugins/sqlite-database-integration ]; then
  echo "sqlite plugin not installed, installing now"

  # Create a temporary file
  if command -v mktemp &> /dev/null; then
    temp_zip=$(mktemp)
  else
    temp_zip="/tmp/sqlite-plugin.zip"
    touch "$temp_zip"
  fi

  curl -s -o "$temp_zip" https://downloads.wordpress.org/plugin/sqlite-database-integration.zip &&
    unzip "$temp_zip" -d /var/www/html/wp-content/plugins/ &&
    chown -R www-data:www-data /var/www/html/wp-content/plugins/sqlite-database-integration &&
    cp -p /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy /var/www/html/wp-content/db.php &&
    rm "$temp_zip"
fi

#!/bin/bash

# Check if the plugin is already installed to avoid redundant operations
if [ ! -d /var/www/html/wp-content/plugins/sqlite-database-integration ]; then
  # Unzip and copy the plugin into wp-content/plugins
  /usr/local/bin/install-sqlite-plugin.sh
fi

# Continue running the main process (like the WordPress server)
exec "$@"

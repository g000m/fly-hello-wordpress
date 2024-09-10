#!/usr/bin/env bash
set -Eeuo pipefail

# Check if the plugin is already installed to avoid redundant operations
if [ ! -d /var/www/html/wp-content/plugins/sqlite-database-integration ]; then
    # Install the SQLite plugin using the install-sqlite-plugin.sh script
    /usr/local/bin/install-sqlite-plugin.sh
fi


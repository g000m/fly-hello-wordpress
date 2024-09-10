#!/bin/bash
set -e

echo "Running custom setup..."

# For example: installing a plugin
/usr/local/bin/install-sqlite-plugin.sh

echo "Custom setup done!"

# Call the original entrypoint with the provided arguments
exec docker-entrypoint.sh "$@"

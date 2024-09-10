# Use the official WordPress image
FROM wordpress:latest

# Install necessary tools and download & install wp-cli in a single RUN command
RUN apt update -y && \
    apt install -y vim-tiny unzip curl && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the plugin installer script to a temporary location and make it executable
COPY ./install-sqlite-plugin.sh /usr/local/bin/install-sqlite-plugin.sh
RUN chmod +x /usr/local/bin/install-sqlite-plugin.sh

# Copy the entrypoint script to ensure the plugin is installed after the volume is mounted and make it executable
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]

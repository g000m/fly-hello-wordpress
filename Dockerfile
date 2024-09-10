# Use the official WordPress image
FROM wordpress:latest

# Install necessary tools
RUN apt update -y && apt install -y vim-tiny unzip curl

# Copy the plugin installer script to a temporary location
COPY ./install-sqlite-plugin.sh /usr/local/bin/install-sqlite-plugin.sh

# Make the script executable
RUN chmod +x /usr/local/bin/install-sqlite-plugin.sh

# Copy the entrypoint script to ensure the plugin is installed after the volume is mounted
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# download & install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Set the entrypoint script
ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]

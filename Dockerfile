# Use the official WordPress image
FROM wordpress:latest

# Install necessary tools and download & install wp-cli in a single RUN command
RUN apt update -y && \
    apt install -y vim-tiny unzip curl && \
    alias vim=vi && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY custom.ini $PHP_INI_DIR/conf.d/
COPY mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf
COPY .htaccess /var/www/html/.htaccess
RUN chown www-data:www-data /var/www/html/.htaccess


# Download and extract the SQLite plugin, set correct ownership, and clean up
RUN curl -O https://downloads.wordpress.org/plugin/sqlite-database-integration.zip && \
    unzip sqlite-database-integration.zip -d /var/www/html/wp-content/plugins/ && \
    chown -R www-data:www-data /var/www/html/wp-content/plugins/sqlite-database-integration && \
    cp -p /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy /var/www/html/wp-content/db.php && \
    rm sqlite-database-integration.zip

# Set the entrypoint script
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]

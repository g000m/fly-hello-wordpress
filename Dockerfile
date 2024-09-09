# see https://hub.docker.com/_/wordpress for alternative tags you can use
FROM wordpress:latest

# Install necessary tools
RUN apt update -y && apt install -y vim-tiny unzip

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Download and unzip the plugin
RUN curl -O https://downloads.wordpress.org/plugin/sqlite-database-integration.zip \
    && unzip sqlite-database-integration.zip -d /var/www/html/wp-content/plugins/ \
#    && cp -r ./sqlite-database-integration /var/www/html/wp-content/plugins/ \
    && chown -R www-data:www-data /var/www/html/wp-content/plugins/sqlite-database-integration \
    && cp -p /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy /var/www/html/wp-content/db.php \
    && rm sqlite-database-integration.zip


# Copy startup script to container

# check if file exists
RUN #test -f install-sqlite-plugin.sh && echo "File exists" || echo "File does not exist"
#COPY install-sqlite-plugin.sh /usr/local/bin/install-sqlite-plugin.sh
RUN #chmod +x /usr/local/bin/install-sqlite-plugin.sh

# Verify WP-CLI installation
RUN wp --info

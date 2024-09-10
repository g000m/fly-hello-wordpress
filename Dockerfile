# see https://hub.docker.com/_/wordpress for alternative tags you can use
FROM wordpress:latest

# Install necessary tools
RUN apt update -y && apt install -y vim-tiny unzip



# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp --info

VOLUME ["/var/www/html/wp-content"]

COPY --chown=www-data:www-data ./install-sqlite-plugin.sh /var/www/html/install-sqlite-plugin.sh
RUN chmod u+x /var/www/html/install-sqlite-plugin.sh

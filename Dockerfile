# see https://hub.docker.com/_/wordpress for alternative tags you can use
FROM wordpress:latest

RUN apt update -y && apt install -y vim-tiny

COPY .htaccess /var/www/html/.htaccess
RUN chown www-data:www-data /var/www/html/.htaccess

COPY custom.ini $PHP_INI_DIR/conf.d/

COPY update_cloudflare_ips.sh /usr/local/bin/update_cloudflare_ips.sh
RUN chmod +x /usr/local/bin/update_cloudflare_ips.sh
RUN /usr/local/bin/update_cloudflare_ips.sh


# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Verify WP-CLI installation
#RUN #wp --info



# Optional: Create an entrypoint script to run WP-CLI commands after container starts
#COPY entrypoint.sh /usr/local/bin/entrypoint.sh
#RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint to custom script
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

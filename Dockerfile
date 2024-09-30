# Use the official WordPress image
FROM tjend/alpine-nginx-phpfpm-wordpress:latest

# Install necessary tools and download & install wp-cli in a single RUN command
RUN apk update && \
    apk add --no-cache unzip curl php82-phar && \
#    apk add php82-phar && \
    alias vim=vi && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY custom.ini /etc/php82/conf.d/
#COPY mpm_prefork.conf /etc/apache2/conf.d/mpm_prefork.conf
#COPY .htaccess /var/www/.htaccess
RUN chown -R nobody:nogroup /var/www/ && \
    find . -type d -exec chmod 755 {} \; && \
    find . -type f -exec chmod 644 {} \;



# see https://hub.docker.com/_/wordpress for alternative tags you can use
FROM wordpress:latest

# Install necessary tools
RUN apt update -y && apt install -y vim-tiny unzip

COPY ./install-sqlite-plugin.sh /usr/local/bin/install-sqlite-plugin.sh
RUN chmod +x /usr/local/bin/install-sqlite-plugin.sh

COPY ./ks_entrypoint.sh /usr/local/bin/ks_entrypoint.sh
RUN chmod +x /usr/local/bin/ks_entrypoint.sh


# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp --info



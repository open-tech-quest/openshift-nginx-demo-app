FROM registry.access.redhat.com/hi/core-runtime:latest-builder AS builder
USER 0
COPY nginx-example-app/logging.conf /var/tmp/logging.conf
COPY nginx-example-app/index.html /var/tmp/index.html

# Update index.html
RUN sed -i "s/REPLACEME/$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)/" /var/tmp/index.html

# Update logging conf
RUN sed -i "s/REPLACEME/$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)/" /var/tmp/logging.conf

# Create /otq-challenge-flag.txt
RUN echo $(tr -dc A-Za-z0-9 </dev/urandom | head -c 16) > /var/tmp/otq-challenge-flag.txt


# FROM registry.access.redhat.com/ubi9/nginx-124:1
FROM registry.access.redhat.com/hi/nginx:latest


# Add application sources
# COPY test-app/nginx.conf "${NGINX_CONF_PATH}"
# COPY nginx-example-app/logging.conf "${NGINX_DEFAULT_CONF_PATH}"
COPY  nginx-example-app/*.html \
      nginx-example-app/*.ico \
      nginx-example-app/*.css \
      nginx-example-app/*.png \
      /usr/share/nginx/html/

COPY --from=builder  /var/tmp/logging.conf /etc/nginx/conf.d/
COPY --from=builder  /var/tmp/index.html /usr/share/nginx/html/
COPY --from=builder  /var/tmp/otq-challenge-flag.txt /var/tmp/otq-challenge-flag.txt

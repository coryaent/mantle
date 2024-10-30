FROM mariadb:11.4

EXPOSE 4567

LABEL org.opencontainers.image.authors="Corya Enterprises, LLC" \
      org.opencontainers.image.title="Mantle" \
      org.opencontainers.image.description="MariaDB Database for relational SQL with Automatic Bootstrapping" \
      org.opencontainers.image.documentation="https://github.com/coryaent/mantle/blob/master/README.md" \
      org.opencontainers.image.base.name="docker.io/library/ubuntu:%%SUITE%%" \
      org.opencontainers.image.licenses="GPL-2.0" \
      org.opencontainers.image.source="https://github.com/coryaent/mantle" \
      org.opencontainers.image.vendor="Corya Enterprises, LLC" \
      org.opencontainers.image.version="%%MARIADB_VERSION_BASIC%%" \
      org.opencontainers.image.url="https://github.com/coryaent/mantle"

COPY ./bootstrap.sh /usr/local/bin/bootstrap.sh

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]

CMD ["mariadbd"]

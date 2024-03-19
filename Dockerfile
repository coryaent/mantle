FROM mariadb:lts

COPY ./bootstrap.sh /usr/local/bin/bootstrap.sh

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]

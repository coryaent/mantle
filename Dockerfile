FROM mariadb:lts

EXPOSE 4567

COPY ./bootstrap.sh /usr/local/bin/bootstrap.sh

ENTRYPOINT ["/usr/local/bin/bootstrap.sh"]

CMD ["mariadbd"]

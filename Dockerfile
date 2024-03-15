FROM debian:bookworm

RUN apt-get update && apt-get upgrade && apt-get install -y \
    wget libaio1 libmecab2 libnuma1 libtirpc3 libgssapi-krb5-2 libtirpc-common libk5crypto3 libkrb5-3 libkrb5support0 libkeyutils1 &&\
    wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-server-core_8.0.36-1debian12_amd64.deb &&\
    dpkg -i ./mysql-community-server-core_8.0.36-1debian12_amd64.deb && rm ./mysql-community-server-core_8.0.36-1debian12_amd64.deb &&\
    wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client-core_8.0.36-1debian12_amd64.deb &&\
    dpkg -i ./mysql-community-client-core_8.0.36-1debian12_amd64.deb && rm ./mysql-community-client-core_8.0.36-1debian12_amd64.deb

COPY ./my.cnf /etc/mysql/my.cnf
COPY ./entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]

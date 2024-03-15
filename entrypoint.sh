#!/bin/bash
mkdir -p /etc/mysql/conf.d/
mkdir -p /var/lib/mysql-files/
mkdir -p /var/run/mysqld/
mysqld --initialize-insecure
mysqld

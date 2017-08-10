#!/bin/bash
# Fix: After start put some owners on some files.

chown -R mysql.mysql /var/lib/mysql
chown -R www-data:www-data /var/www/html

if [ -f /var/lib/mysql/run_mysql ]; then
  sleep 10s
  mysql -u root < /setup/mysql_wikkawiki.sql
  rm /var/lib/mysql/run_mysql
fi

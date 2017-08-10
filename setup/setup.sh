#!/bin/bash
# Fix: After start put some owners on some files.

chown -R mysql.mysql /var/lib/mysql
chown -R www-data:www-data /var/www/html

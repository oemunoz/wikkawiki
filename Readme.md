# Supported tags and respective `Dockerfile` links

-       [`1.4.0` , `latest` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0/Dockerfile)
-       [`1.3.7-php5-mariadb` , `1.3.7` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.3.7_php5_mariadb/Dockerfile)
-       [`dev` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/master/Dockerfile)
-       [`1.4.0-pre` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0-pre/Dockerfile)
-       [`1.4.0-pre_lite` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0-pre_lite/Dockerfile)
-       [`1.4.0-pre_arm32v7_lite` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0-pre_arm32v7_lite/Dockerfile)


# WikkaWiki docker container
![WikkaWiki.](https://github.com/oemunoz/wikkawiki/raw/master/images/wikkawikiWizzard.png)

WikkaWiki is a flexible, standards-compliant and lightweight wiki engine written in PHP, which uses MariaDB/MySQL/SQLite to store pages.
[http://wikkawiki.org/HomePage](http://wikkawiki.org/HomePage)

## Image description:

This is a resumed HowTo, for a long description follow the link to the [WikkaWiki](http://wikkawiki.org/Wikka-Docker).

From the 1.4.0 stable version this docker dont use supervisord, but you can use other alternatives like docker-compose, check the example below.

### The Stable (latest) Version:
No internal MariaDB/MySql Database Engine

#### MariaDB/SQLite options for external MariaDB/MySql or internal SqLite.
[`1.4.0`, `latest` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0/Dockerfile), **stable-release**.

```bash
docker run -d -p 80:80 oems/wikkawiki
```

- Run out of the box, to install WikkaWikki page.
- Run the latest Version of WikkaWiki (1.4.0), from the github repository.
- Run with PHP 7 (Developer testing).
- Support for MariaDB/MySql but not internal engine.
- Support for SqLite database, with configuration option from the installer.

----

#### MariaDB on the same Docker with Supervisord.
[`1.3.7` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.3.7_php5_mariadb/Dockerfile), **old-release**.

When you run this docker with the basic minimum options:

```bash
docker run -d -p 80:80 oems/wikkawiki:1.3.7_php5_mariadb
```

- Run out of the box, to install WikkaWikki page.
- Run the latest Stable Version of WikkaWiki (1.3.7), from the tar.gz on the GitHub Official site.
- Run with PHP 5.5 (Developer tested).
- A new WikkaWiki database over MariaDB 5.5.57, with the next DB/user/password options.

----

### Running Installer for first time.

Connect with the web server on the 80 tcp port of the docker server, you can use the SQLite option;

![Install process.](https://github.com/oemunoz/wikkawiki/raw/master/images/sqlite_select.png)

> Note: If you select the SQLite option ignore other database fields.

If you select mysql option you must to use the default password (on any case remember to change this password):

![Install process.](https://github.com/oemunoz/wikkawiki/raw/master/images/database_user.png)

**Default password**:
```text
wikka-password
```

Also, you can follow the instructive for more detail on the install process:

[http://docs.wikkawiki.org/WikkaInstallation](http://docs.wikkawiki.org/WikkaInstallation)

With this default option, you run the database into the container, then **if you delete your container you delete your database also**, remember to make backup.

#### Using docker-compose with this docker.
Now in your work directory, is a directory named **mysql_org/ **, you can use this database files on your owns instances of wikkawiki.

![Install process.](https://github.com/oemunoz/wikkawiki/raw/master/images/wizzard_dockercomposer.png)

**Default password**:
```text
wikka-password
```

For example docker-compose.yml:

```yaml
version: '2'

services:
  mariadb:
   image: mariadb
   hostname: mariadb
   environment:
    - MYSQL_ROOT_PASSWORD=root-password
    - MYSQL_DATABASE=wikka
    - MYSQL_USER=wikka
    - MYSQL_PASSWORD=wikka-password
   volumes:
     - $PWD/mysql:/var/lib/mysql

  wiki:
   image: oems/wikkawiki:latest
   links:
     - mariadb
   ports:
     - '80:80'
```
and the run it:
```bash
docker-compose up -d
```

### Using your own uploads and your plugins also:

```bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql -v $PWD/wikka.config.php:/var/www/html/wikka/wikka.config.php -v $PWD/uploads:/var/www/html/wikka/uploads -v $PWD/plugins:/var/www/html/wikka/plugins oems/wikkawiki
```

### Build your own:

Modify the mysql_wikkawiki.sql with your own user and database definitions and build the image:

```bash
git git@github.com:oemunoz/wikkawiki.git wikkawiki
cd wikkawiki
docker build -t "wikkawiki" .
```

## FAQs and TODOs

- This is ready for production:

> R: For now, is not, becose this DockerFile was build thinking to help to the developers only.

- [ ] TODO: Fix some distortion on the logo image.
- [ ] TODO: Add some links to docs and tutorials to the Readme.
- [ ] TODO: Add some setup pictures to the Readme.

## History

- 180519: Upgrade to 1.4.0 release.
- 180519: Removed embemed databases.
- 170810: New, repository WikkaWiki Lite instance.
- 170810: Now, the default database is MariaDB.
- 170810: New directory for scripts and config (/setup)
- 170810: New directory for supervisord, and separated daemons.
- 161118: Adding tags, added a new picture, 1.4.0 pre tag added, upgrading to ADD Dockerfile.
- 160707: WikkaWiki now uses /wikka not the root of apache, but works out of the box.
- 160705: Basic Initial Version.

## Credits

All WikkaWiki develops.
[http://wikkawiki.org/CreditsPage](http://wikkawiki.org/CreditsPage)

## License

GNU General Public License

![MariaDB.](https://github.com/oemunoz/wikkawiki/raw/master/images/mariadb.png)![SQLite.](https://github.com/oemunoz/wikkawiki/raw/master/images/sqlite.jpg)![Mysql.](https://github.com/oemunoz/wikkawiki/raw/master/images/MySQL.png)![PHP.](https://github.com/oemunoz/wikkawiki/raw/master/images/php.png)

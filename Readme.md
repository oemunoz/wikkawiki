# Supported tags and respective `Dockerfile` links

-	[`1.3.7` , `latest` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/master/Dockerfile)
-	[`1.4.0-pre` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0-pre/Dockerfile)
-	[`1.4.0-pre_lite` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0-pre_lite/Dockerfile)

# WikkaWiki docker container
![WikkaWiki.](https://github.com/oemunoz/wikkawiki/raw/master/images/wikkawikiWizzard.png)

WikkaWiki is a flexible, standards-compliant and lightweight wiki engine written in PHP, which uses MariaDB/MySQL/SQLite to store pages.
[http://wikkawiki.org/HomePage](http://wikkawiki.org/HomePage)

![MariaDB.](https://github.com/oemunoz/wikkawiki/raw/master/images/mariadb.png)![SQLite.](https://github.com/oemunoz/wikkawiki/raw/master/images/sqlite.jpg)![Mysql.](https://github.com/oemunoz/wikkawiki/raw/master/images/MySQL.png)![PHP.](https://github.com/oemunoz/wikkawiki/raw/master/images/php.png)

## Image description:

This is a resumed HowTo, for a long description follow the link to the [WikkaWiki](http://wikkawiki.org/Wikka-Docker).

![Flavours.](https://github.com/oemunoz/wikkawiki/raw/master/images/flavours.png)

### The Stable (latest) Version:

#### MariaDB on the same Docker with Supervisord.
[`1.3.7` , `latest` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/master/Dockerfile), **stable-release**.

When you run this docker with the basic minimum options:

```bash
docker run -d -p 80:80 oems/wikkawiki:latest
```

- Run out of the box, to install WikkaWikki page.
- Run the latest Stable Version of WikkaWiki (1.3.7), from the tar.gz on the GitHub Official site.
- Run with PHP 5.5 (Developer tested).
- A new WikkaWiki database over MariaDB 5.5.57, with the next DB/user/password options.

----

### The Beta Version:

#### MariaDB/SQLite options on the same Docker with Supervisord.
[`1.4.0-pre` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0-pre/Dockerfile), **pre-release candidate**.

or for the pre-release candidate:

```bash
docker run -d -p 80:80 oems/wikkawiki:1.4.0-pre
```

- Run out of the box, to install WikkaWikki page.
- Run the latest Version of WikkaWiki (1.4.0), from the github repository.
- Run with PHP 7.0 (Developer testing).
- A new WikkaWiki database over MariaDB 10.0.31 (testing), with the next DB/user/password options.
- Support for SqLite database, with configuration option from the installer.

----

### The Beta Lite Version:
No internal MariaDB/MySql Database Engine

#### MariaDB/SQLite options for external MariaDB/MySql or internal SqLite.
[`1.4.0-pre_lite` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0-pre_lite/Dockerfile), **pre-release candidate**.

or for the pre-release candidate:

```bash
docker run -d -p 80:80 oems/wikkawiki:1.4.0-pre_lite
```

- Run out of the box, to install WikkaWikki page.
- Run the latest Version of WikkaWiki (1.4.0), from the github repository.
- Run with PHP 7.1 (Developer testing).
- Support for MariaDB/MySql but not internal engine.
- Support for SqLite database, with configuration option from the installer.

----

### Running Installer for first time (Internal Database Engine).

Connect with the web server on the 80 tcp port of the docker server, and use the default password (on any case remember to change this password):

![Install process.](https://github.com/oemunoz/wikkawiki/raw/master/images/database_user.png)

**Default password**:
```text
wikka-password
```

Also, you can follow the instructive for more detail on the install process:

[http://docs.wikkawiki.org/WikkaInstallation](http://docs.wikkawiki.org/WikkaInstallation)

With this default option, you run the database into the container, then **if you delete your container you delete your database also**, remember to make backup.

### Using your own database files

The internal database use MariaDB 5.5.57 for WikkaWiki versions < 1.4.0 and MariaDB 10.0.31 for WikkaWiki >= 1.4.0, using your own database (**make backup** of your original database before to load this docker):

```bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql oems/wikkawiki
```

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
   image: oems/wikkawiki:1.4.0-pre_lite
   links:
     - mariadb
   ports:
     - '80:80'
```
and the run it:
```bash
docker-compose up -d
```

### Using your own database and your own configuration file.

You can use your own configuration options.

```bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql -v $PWD/wikka.config.php:/var/www/html/wikka/wikka.config.php oems/wikkawiki
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

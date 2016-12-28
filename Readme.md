# Supported tags and respective `Dockerfile` links

-	[`1.3.7` , `latest` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/master/Dockerfile)
-	[`1.4.0-pre` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/1.4.0-pre/Dockerfile)

# WikkaWiki docker container
![WikkaWiki.](https://github.com/oemunoz/wikkawiki/raw/master/images/wikkawikiWizzard.png)

WikkaWiki is a flexible, standards-compliant and lightweight wiki engine written in PHP, which uses MySQL to store pages.
[http://wikkawiki.org/HomePage](http://wikkawiki.org/HomePage)

## To run the image:

This is a resumed HowTo, for a long description follow the link to the [WikkaWiki](http://wikkawiki.org/Wikka-Docker).

### To run the default image (new Install):
When you run this docker with the basic minimum options:

```bash
docker run -d -p 80:80 oems/wikkawiki:latest
```

- Run out of the box, to install WikkaWikki page.
- Run the latest Version of WikkaWiki (1.3.7), from the website tar.gz.
- Run with PHP 5 (Developer tested).
- A new WikkaWiki database over MySql 5.5 (tested), with the next DB/user/password options. (mysql requiere at least 1G of RAM)


or for the pre-release candidate:

```bash
docker run -d -p 80:80 oems/wikkawiki:1.4.0-pre
```

- Run out of the box, to install WikkaWikki page.
- Run the latest Version of WikkaWiki (1.4.0), from the github tar.gz.
- Run with PHP 7.0.8 (Developer testing).
- A new WikkaWiki database over MySql 5.7.16 (testing), with the next DB/user/password options.

The default database:
```text
wikka
```

default database user:

```text
wikka
```

default database password:

```text
wikka-password
```

With this default option, you run the database into the container, then **if you delete your container you delete your database also**, remember to make backup.

### Using your own database files

The internal database use MySql 5.5, using your own database (make backup of your original database before to load this docker):

```bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql oems/wikkawiki
```

#### How to get de default an clean database from this docker.

You can to extract the default database if you want to use this image into some docker-compose for example:

```bash
docker run --rm -it -v $PWD/mysql_org:/var/lib/mysql oems/wikkawiki sh -c "tar -xvf /mysql_basic.tar"
```

Now in your work directory, is a directory named **mysql_org/ **, you can use this database files on your owns instances of wikkawiki.

For example docker-compose:

```yaml
services:
  db:
   image: mariadb
   volumes:
     - $PWD/mysql_org:/var/lib/mysql
```

### Using your own database and your own configuration file.

You can use your own configuration options.

```bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql -v $PWD/wikka.config.php:/var/www/html/wikka/wikka.config.php oems/wikkawiki
```

If you use a external database you dont need the mysql volume.

```bash
docker run -d -p 80:80 -v $PWD/wikka.config.php:/var/www/html/wikka.config.php oems/wikkawiki
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

- 161118: Adding tags, added a new picture, 1.4.0 pre tag added, upgrading to ADD Dockerfile.
- 160707: WikkaWiki now uses /wikka not the root of apache, but works out of the box.
- 160705: Basic Initial Version.

## Credits

All WikkaWiki develops.
[http://wikkawiki.org/CreditsPage](http://wikkawiki.org/CreditsPage)

## License

GNU General Public License

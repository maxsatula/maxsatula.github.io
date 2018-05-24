# Oracle APEX in Docker for Windows

## Prerequisites
  - Docker for Windows https://www.docker.com/docker-windows
  - Git repository https://github.com/oracle/docker-images
  - Oracle XE installation package `oracle-xe-11.2.0-1.0.x86_64.rpm.zip` from http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html
  - *(optional)* Apex installation package `apex_5.1.4.zip` from http://www.oracle.com/technetwork/developer-tools/apex/downloads/index.html
  - *(optional)* https://materialapex.com

## Build a Docker Image

Change directory to `docker-images/OracleDatabase/SingleInstance/dockerfiles/11.2.0.2`
and copy `oracle-xe-11.2.0-1.0.x86_64.rpm.zip` there

```sh
# because we have Windows, this is a replacement for
#     buildDockerImage.sh -v 11.2.0.2 -x
docker build --force-rm=true --no-cache=true --shm-size=1G -t oracle/database:11.2.0.2-xe -f Dockerfile.xe .
```

## Create a Volume for Database

```sh
docker volume create oradata
```

## Run Oracle

```sh
docker run --detach --rm --publish 8080:8080 --publish 1521:1521 --name oracle-xe --shm-size 1GB --mount type=volume,source=oradata,destination=/u01/app/oracle/oradata oracle/database:11.2.0.2-xe
```

## Check Running Oracle

```sh
docker logs oracle-xe --follow
```

## Login to Apex

http://localhost:8080/apex/f?p=4950 - will stop working after APEX upgrade to 5.1

http://localhost:8080/apex/f?p=4550 - INTERNAL ADMIN/sys_password

## Upgrade to Apex 5.1

```sh
docker cp apex_5.1.4.zip oracle-xe:/
docker exec -ti oracle-xe bash
```

```sh
chown oracle apex_5.1.4.zip
su - oracle
unzip -q /apex_5.1.4.zip
PATH=/u01/app/oracle/product/11.2.0/xe/bin:$PATH
. oraenv # enter XE and /u01/app/oracle/product/11.2.0/xe
cd apex
sqlplus / as sysdba
```

```sql
@apexins SYSAUX SYSAUX TEMP /i/
```

```sh
sqlplus / as sysdba
```

```sql
-- specify parent directory containing apex
@apex_epg_config.sql /u01/app/oracle
```

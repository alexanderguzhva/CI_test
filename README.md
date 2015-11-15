# CI_test

## Docker
Use docker 1.9

Create a network with name 'internal': 
```bash
docker network create internal
```

So, let all containers to be run within this 'internal' docker network.


## Mail server
Dockerfile from tvial/docker-mailserver repo ([github](https://github.com/tomav/docker-mailserver))

[Script](mailserver/runme.sh) for setting up the docker image called 'mail'.

Container's files are stored in /srv/docker/mailserver/ on a host machine.

/srv/docker/mailserver/postfix/accounts.cf file contains something like this:
```
username@linux.local|password
gitlab_notification@linux.local|password
gitlab_noreply@linux.local|password
gitlab_incomping@linux.local|password
gitlab_mailer@linux.local|password
```


## Redis
Dockerfile from sameersbn/redis:latest repo ([github](https://github.com/sameersbn/docker-redis))

[Script](redis/runme.sh) for setting up the docker image called 'redis'.

Container's files are stored in /srv/docker/redis/ on a host machine.

Please note that [script](redis/runme.sh) does not contains publishing ports options, so port 6379 is available only for containers within 'internal' docker network. Also, this redis server is not password protected.


## PostgreSQL
Dockerfile from sameersbn/postgresql:9.4-7 ([github]https://github.com/sameersbn/docker-postgresql))

[Script](postgresql/runme.sh) for setting up the docker image called 'postgresql'.

[Script](postgresql/runme.sh) contains 'DB_USER' and 'DB_PASS' options for gitlab base 'DB_NAME'. 

Container's files are stored in /srv/docker/postgresql/ on a host machine.


## Busybox for testing
```bash
docker run -it --rm --net=internal busybux bash
```

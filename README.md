# CI_test

## Docker
Use docker 1.9

Create a network with name 'internal': 
```bash
docker network create internal
```

So, let all containers to be run within this 'internal' docker network


## Mail server
Dockerfile from tvial/docker-mailserver repo ([github](https://github.com/tomav/docker-mailserver))

[Script](mailserver/runme.sh) for setting up the docker image called 'mail'

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

[Script](redis/runme.sh) for setting up the docker image called 'redis'

Please note that [script](redis/runme.sh) does not contains publishing ports options, so port 6379 is available only for containers within 'internal' docker network


## Busybox for testing
```bash
docker run -it --rm --net=internal busybux bash
```

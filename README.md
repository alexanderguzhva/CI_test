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

[Script](mailserver/runme.sh) for setting up the docker image

/srv/docker/mailserver/postfix/accounts.cf file contains something like this:
```
username@linux.local|password
gitlab_notification@linux.local|password
gitlab_noreply@linux.local|password
gitlab_incomping@linux.local|password
gitlab_mailer@linux.local|password
```

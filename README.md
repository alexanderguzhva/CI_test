# CI_test

Some CI for my laptop

## Docker
Use docker 1.9

Create a network with name 'internal': 
```bash
docker network create internal
```

So, let all containers to be run within this 'internal' docker network.


## Mail server
Docker image from tvial/docker-mailserver repo ([github](https://github.com/tomav/docker-mailserver))

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
Docker image from sameersbn/redis:latest repo ([github](https://github.com/sameersbn/docker-redis))

[Script](redis/runme.sh) for setting up the docker image called 'redis'.

Container's files are stored in /srv/docker/redis/ on a host machine.

Please note that [script](redis/runme.sh) does not contains publishing ports options, so port 6379 is available only for containers within 'internal' docker network. Also, this redis server is not password protected.


## PostgreSQL
Docker image from sameersbn/postgresql:9.4-7 ([github](https://github.com/sameersbn/docker-postgresql))

[Script](postgresql/runme.sh) for setting up the docker image called 'postgresql'.

[Script](postgresql/runme.sh) contains 'DB_USER' and 'DB_PASS' options for gitlab base 'DB_NAME'. 

Container's files are stored in /srv/docker/postgresql/ on a host machine.

## gitlab
Docker image from sameersbn/gitlab:latest (([github](https://github.com/sameersbn/docker-gitlab))

[Script](gitlab/runme.sh) for setting up docker image called 'gitlab'.

- Options 'SMTP_PASS' and 'IMAP_PASS' should match one for 'mail' docker image (check /srv/docker/mailserver/postfix/accounts.cf)
- Option 'SMTP_AUTHENTICATION' should be set to 'CRAM_MD5' (because 'mail' recognizes CRAM_MD5 and DIGEST_MD5 and 'gitlab' works with 'PLAIN', 'LOGIN' and 'CRAM_MD5')
- external ports were set to 20022 (SSH) and 20080 (HTTP)
- 'DB_USER', 'DB_PASS', 'DB_NAME' options should match ones for 'postgresql' container
- '*_HOST' options contain hostname like 'xyz.internal' that should match docker network name 'internal'. One could use 'xyz' instead of 'internal', though

[Script](gitlab/ssh/sshkg.sh) for generating SSH key. 

I also added the following to '~/.ssh/config' file:
```
Host gitlab
    HostName localhost
    User username@linux.local
    Port 20022
    IdentityFile /home/username/.ssh/gitlab_id_rsa
```

In order to work with Intellij IDEA I had to go to Menu/File/Settings/Version Control/Git and set 'SSH executable' to 'native'. This is because Intellij IDEA uses ~/.ssh/id_rsa file for git. If a keyfile with a non-standard name is used, then a 'native' option should be used instead of 'built-in'.

### Set up gitlab
- Go to HTTP, sign up, get an email on 'username@linux.local', activate.
- Add SSH keys (basically, copy and paste generated the whole test in ~/.ssh/gitlab_id_rsa.pub as a new SSH key in gitlab's UI in User Profile settings)

### Problems with gitlab
Login to gitlab:
```bash
docker exec -it -u root gitlab bash
```

Check sshd:
```bash
cat /var/log/gitlab/supervisor/sshd.log
```

Check authorized SSH keys:
```bash
cat /home/git/.ssh/authorized_keys
```


## Teamcity
Docker image from sjoerdmulder/teamcity:latest ([github](https://github.com/sjoerdmulder/teamcity-docker))

[Script](teamcity/runme.sh) for setting up docker image called 'teamcity'. But the postgresql database should be set up before setting up teamcity

Container's files are stored in /srv/docker/teamcity/ on a host machine.

### Set up postgresql database
Execute within the 'postgresql' container:
```bash
docker exec -it -u postgres postgresql psql
```

Run in psql:
```
create role teamcity with login password 'teamcity';
```

Run in psql:
```
create role teamcity with login password 'teamcity';
```

Quit from psql:
```
\q
```





## Set up a mail client (like the Mozilla Thunderbird)
Email is something like 'username@linux.local', both SMTP and IMAP servers point to 'localhost'.




## Start containers
```
docker start mail
docker start redis
docker start postgresql
docker start gitlab
docker start teamcity
```



## Busybox for testing
```bash
docker run -it --rm --net=internal busybux bash
```

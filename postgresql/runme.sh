docker run --name postgresql \
    -d \
    -h postgresql.local \
    --net=internal \
    -v /srv/docker/postgresql/data:/var/lib/postgresql \
    -e 'PSQL_TRUST_LOCALNET=true' \
    --env="USERMAP_UID=$(id -u postgres)" \
    --env="USERMAP_GID=$(id -g postgres)" \
    --env 'DB_NAME=gitlabhq_production' \
    --env 'DB_USER=someuser' --env 'DB_PASS=somepassword' \
    sameersbn/postgresql:9.4-7
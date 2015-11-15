docker run --name redis \
       -d \
       --volume /srv/docker/redis:/var/lib/redis \
       --net=internal \
       sameersbn/redis:latest
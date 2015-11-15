docker run --name mail \
       -v "/srv/docker/mailserver/postfix":/tmp/postfix \
       -v "/srv/docker/mailserver/spamassassin":/tmp/spamassassin \
       -p "25:25" \
       -p "143:143" \
       -p "587:587" \
       -p "993:993" \
       -h mail.local \
       --net=internal \
       tvial/docker-mailserver
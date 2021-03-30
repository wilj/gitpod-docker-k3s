#!/bin/bash
set -euox

DOMAIN=$1
EMAIL=$2
WORKDIR=$(pwd)/tmpcerts

mkdir -p $WORKDIR

sudo docker run -it --rm --name certbot \
    -v $(pwd)/tmpcerts/etc:/etc/letsencrypt \
    -v $(pwd)/tmpcerts/var:/var/lib/letsencrypt \
    -v $(pwd)/secrets/cloudflare.ini:/etc/cloudflare.ini:ro \
        certbot/dns-cloudflare certonly \
        --agree-tos --no-eff-email \
    --email $EMAIL \
    --dns-cloudflare \
    --dns-cloudflare-credentials /etc/cloudflare.ini \
    -d gitpod.$DOMAIN \
    -d *.gitpod.$DOMAIN \
    -d *.ws.gitpod.$DOMAIN \
    -d gitlab.$DOMAIN 

sudo find $(pwd)/tmpcerts/etc/live -name "*.pem" -exec sudo cp {} $(pwd)/certs \;
sudo chown -R $USER:$USER $(pwd)/certs 
chmod -R 700 $(pwd)/certs 

sudo rm -rf $WORKDIR

openssl dhparam -out $(pwd)/certs/dhparams.pem 2048
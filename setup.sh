#!/bin/bash
set -euox

DOMAIN=$1
DNSSERVER=$2

# TEST:
docker build . -t gitpod-k3s-local
docker run \
    --name gitpod \
    -v /run/containerd/containerd.sock:/run/containerd/containerd.sock \
    -v /tmp/workspaces:/var/gitpod/workspaces \
    -v $(pwd)/certs:/certs \
    -e DOMAIN=$DOMAIN \
    -e DNSSERVER=$DNSSERVER \
    --privileged \
    -p 81:80 \
    -p 444:443 \
    gitpod-k3s-local
    
    
## ORIGINAL:
#docker build . -t gitpod-k3s-local
#docker run \
#    --name gitpod \
#    -v /run/containerd/containerd.sock:/run/containerd/containerd.sock \
#    -v /tmp/workspaces:/var/gitpod/workspaces \
#    -v $(pwd)/certs:/certs \
#    -e DOMAIN=$DOMAIN \
#    -e DNSSERVER=$DNSSERVER \
#    --privileged \
#    -p 80:80 \
#    -p 443:443 \
#    gitpod-k3s-local

# Gitpod in a Docker container with k3s and Letsencrypt certificates with DNS challenges

## Prerequisites

- `docker`
- Cloudflare [API key and email](https://certbot-dns-cloudflare.readthedocs.io/en/stable/) stored in $(pwd)/secrets/cloudflare.ini

## Quick Start

### Docker run:

```shell
# creates SSL certs and dhparams
$ ./create-certs.sh <domain> <email>

# builds image, runs k3s cluster in container, and installs Gitpod
$ ./setup.sh <domain> <dns server>

```
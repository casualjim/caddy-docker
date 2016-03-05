#!/bin/sh

apk add --no-cache --purge ca-certificates shared-mime-info jq curl tar gzip
latestv=$(curl -s https://api.github.com/repos/mholt/caddy/releases/latest | jq -r .tag_name)
curl -sL https://github.com/mholt/caddy/releases/download/$latestv/caddy_linux_amd64.tar.gz | tar -xz
apk del --no-cache --purge curl tar gzip jq

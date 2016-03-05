#!/bin/sh

latestv=$(curl -s https://api.github.com/repos/mholt/caddy/releases/latest | jq -r .tag_name)
curl -o ./caddy.tar.gz -L'#' https://github.com/mholt/caddy/releases/download/$latestv/caddy_linux_amd64.tar.gz

docker build -t casualjim/caddy .

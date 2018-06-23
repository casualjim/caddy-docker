#!/bin/bash

set -e -o pipefail

osv=$(uname)
github::download::url() {
  curl -s https://api.github.com/repos/$1/$2/releases/latest | jq -r '.assets[] | select(.name | contains("'"${osv,,}"'_amd64")) | .browser_download_url'
}

github::download::latest() {
  [ -f ./caddy.tar.gz ] && rm ./caddy.tar.gz

  curl -o ./caddy.tar.gz -L'#' $(github::download::url mholt caddy)
}

docker::build::push() {
  latestv=$(curl -s https://api.github.com/repos/$1/$2/releases/latest | jq -r '.tag_name')
  docker build -f ./Dockerfile.scratch -t casualjim/caddy:$latestv -t casualjim/caddy:latest .
  docker push casualjim/caddy
}

github::download::latest
docker::build::push

#!/usr/bin/env bash

set -euxo pipefail


function get_args() {
  "$(dirname $0)/get-metadata.sh" | while IFS= read -r LINE
  do
    ARG_NAME="${LINE%%=*}"
    ARG_VALUE="${LINE#*=}"
    echo " --build-arg CLI_${ARG_NAME^^}=${ARG_VALUE}"
  done
}

: ${IMAGE:="ghcr.io/asssaf/antigravity-cli:latest"}

docker build -t $IMAGE $(get_args) docker/

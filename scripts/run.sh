#!/usr/bin/env bash

set -eu

# usage:
# run.sh --prompt "what is the weather in SF?"

mkdir -p "${HOME}/.gemini"

: ${IMAGE:=ghcr.io/asssaf/antigravity-cli:latest}
: ${GUEST_USER:=user}
: ${COLORTERM:=truecolor}
: ${TZ:="America/Los_Angeles"}

docker run --rm -it \
        -v ${HOME}/.gemini:/home/${GUEST_USER}/.gemini \
        -v ${PWD}:/home/${GUEST_USER}/work \
        -u $(id -u):$(id -g) \
        -e NO_BROWSER=true \
        -e TERM=$TERM \
        -e COLORTERM=$COLORTERM \
        -e TZ="$TZ" \
        $IMAGE "$@"

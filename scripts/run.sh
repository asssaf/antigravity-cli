#!/usr/bin/env bash

set -eu

# usage:
# run.sh --prompt "what is the weather in SF?"

mkdir -p "${HOME}/.gemini"
mkdir -p "${HOME}/.gemini-keyrings"
mkdir -p "${HOME}/.config/configstore/update-notifier-\@google"

: ${IMAGE:=asssaf/agy:latest}
: ${GUEST_USER:=user}
: ${COLORTERM:=truecolor}
: ${TZ:="America/Los_Angeles"}

docker run --rm -it \
        -v ${HOME}/.config/configstore/update-notifier-@google:/home/${GUEST_USER}/.config/configstore/update-notifier-@google \
        -v ${HOME}/.gemini:/home/${GUEST_USER}/.gemini \
        -v ${HOME}/.gemini-keyrings:/home/${GUEST_USER}/.local/share/keyrings \
        -v ${PWD}:/home/${GUEST_USER}/work \
        -u $(id -u):$(id -g) \
        -e NO_BROWSER=true \
        -e TERM=$TERM \
        -e COLORTERM=$COLORTERM \
        -e TZ="$TZ" \
        $IMAGE "$@"

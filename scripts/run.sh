#!/usr/bin/env bash

set -eu

# usage:
# run.sh --prompt "what is the weather in SF?"

mkdir -p "${HOME}/.gemini"

: ${IMAGE:=ghcr.io/asssaf/antigravity-cli:latest}
: ${GUEST_USER:=user}
: ${COLORTERM:=truecolor}
: ${TZ:="America/Los_Angeles"}
: ${PROJECT:="$(basename $PWD)"}
: ${AGY_HOST_CACHE:=""}
: ${AGY_STARTUP_HOOK:=""}

if [ -n "$AGY_HOST_CACHE" ]
then
	mkdir -p $AGY_HOST_CACHE || { echo "Failed to create $AGY_HOST_CACHE. Create it or set AGY_HOST_CACHE=\"\" to disable." >&2 ; exit 1; }
fi

docker run --rm -it --name "agy-${PROJECT}" \
        -v ${HOME}/.gemini:/home/${GUEST_USER}/.gemini \
        -v ${PWD}:/home/${GUEST_USER}/work \
        ${AGY_HOST_CACHE:+-v "${AGY_HOST_CACHE}:/home/${GUEST_USER}/host-cache"} \
        -u $(id -u):$(id -g) \
        -e NO_BROWSER=true \
        -e TERM=$TERM \
        -e COLORTERM=$COLORTERM \
        -e TZ="$TZ" \
        -e AGY_STARTUP_HOOK="${AGY_STARTUP_HOOK}" \
        $IMAGE "$@"

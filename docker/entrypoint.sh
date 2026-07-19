#!/usr/bin/env bash

set -euo pipefail

if [ -v AGY_STARTUP_HOOK ] && [ -n "${AGY_STARTUP_HOOK}" ]; then
    if [ -f "${AGY_STARTUP_HOOK}" ]; then
        source "${AGY_STARTUP_HOOK}"
    else
        echo "Warning: AGY_STARTUP_HOOK file '${AGY_STARTUP_HOOK}' not found" >&2
    fi
fi

exec "/home/${GUEST_USER}/bin/antigravity" "$@"

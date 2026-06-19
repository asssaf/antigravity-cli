#!/usr/bin/env bash

set -euo pipefail

[ -v AGY_STARTUP_HOOK ] && [ -x "${AGY_STARTUP_HOOK}" ] && "${AGY_STARTUP_HOOK}"

exec "/home/${GUEST_USER}/bin/antigravity" "$@"

#!/usr/bin/env bash

set -euo pipefail

exec "/home/${GUEST_USER}/bin/antigravity" "$@"

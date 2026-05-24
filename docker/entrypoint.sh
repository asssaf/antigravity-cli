#!/usr/bin/env bash

set -euo pipefail

mkdir -p ~/.local/share/keyrings
export DBUS_SESSION_BUS_ADDRESS=$(dbus-daemon --session --print-address --fork)

# Force initialization of the default collection with a dummy password
export $(echo -n "dummy" | gnome-keyring-daemon --unlock)

gnome-keyring-daemon --start --components=secrets

exec /antigravity $*

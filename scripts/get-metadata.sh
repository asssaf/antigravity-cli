#!/usr/bin/env bash

set -euo pipefail

DOWNLOAD_BASE_URL=$(curl -fsSL "https://antigravity.google/cli/install.sh" | grep 'DOWNLOAD_BASE_URL=' | cut -d'"' -f2)

MANIFEST_AMD64=$(curl -fsSL "${DOWNLOAD_BASE_URL}/manifests/linux_amd64.json")
VERSION=$(echo "$MANIFEST_AMD64" | sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
URL_AMD64=$(echo "$MANIFEST_AMD64" | sed -n 's/.*"url"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
SHA512_AMD64=$(echo "$MANIFEST_AMD64" | sed -n 's/.*"sha512"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')

MANIFEST_ARM64=$(curl -fsSL "${DOWNLOAD_BASE_URL}/manifests/linux_arm64.json")
URL_ARM64=$(echo "$MANIFEST_ARM64" | sed -n 's/.*"url"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
SHA512_ARM64=$(echo "$MANIFEST_ARM64" | sed -n 's/.*"sha512"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')

if [ -z "$VERSION" ] || [ -z "$URL_AMD64" ] || [ -z "$SHA512_AMD64" ] || [ -z "$URL_ARM64" ] || [ -z "$SHA512_ARM64" ]; then
  echo "Error: Failed to extract all required metadata from manifests" >&2
  exit 1
fi

# Write to GitHub Actions output if GITHUB_OUTPUT environment variable is set
if [[ -v GITHUB_OUTPUT ]]; then
  echo "version=${VERSION}" >> "$GITHUB_OUTPUT"
  echo "url_amd64=${URL_AMD64}" >> "$GITHUB_OUTPUT"
  echo "sha512_amd64=${SHA512_AMD64}" >> "$GITHUB_OUTPUT"
  echo "url_arm64=${URL_ARM64}" >> "$GITHUB_OUTPUT"
  echo "sha512_arm64=${SHA512_ARM64}" >> "$GITHUB_OUTPUT"
else
  # Otherwise just print them
  echo "version=${VERSION}"
  echo "url_amd64=${URL_AMD64}"
  echo "sha512_amd64=${SHA512_AMD64}"
  echo "url_arm64=${URL_ARM64}"
  echo "sha512_arm64=${SHA512_ARM64}"
fi

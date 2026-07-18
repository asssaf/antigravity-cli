# antigravity-cli

[![Docker CI](https://github.com/asssaf/antigravity-cli/actions/workflows/docker-ci.yml/badge.svg)](https://github.com/asssaf/antigravity-cli/actions/workflows/docker-ci.yml)
[![Latest Image Version](https://img.shields.io/github/v/tag/asssaf/antigravity-cli?color=blue&label=version&sort=semver)](https://github.com/asssaf/antigravity-cli/pkgs/container/antigravity-cli)

A lightweight, pre-configured Docker-based environment for Google's Antigravity CLI. This package eliminates setup overhead and ensures that the Antigravity agent runs in a secure, isolated, and multi-architecture environment.

<img width="2506" height="522" alt="antigravity-cli2" src="https://github.com/user-attachments/assets/224e9b38-8a1f-4b62-8e70-d02e073a4835" />


---

## Key Features

- **Portability & Isolation**: Runs Google's Antigravity CLI inside an isolated container with minimal host dependencies.
- **Persistence**: Automatically mounts host `${HOME}/.gemini` to persist agent states, cache, and configuration keys.
- **Seamless Workspace Integration**: Mounts the current working directory (`$PWD`) into the container to allow the agent to read and modify your project files directly.
- **Multi-Architecture Support**: Native builds provided for both `amd64` (x86_64) and `arm64` (ARMv8, Apple Silicon) platforms.
- **Startup Hooks**: Supports launching pre-initialization scripts before starting the Antigravity agent.
- **Continuous Integration**: Automates checking for new upstream Antigravity releases, compiling multi-arch images, and publishing them to GitHub Container Registry (GHCR).

---

## Quick Start

Execute the runner script from your project directory to interact with the Antigravity agent:

```bash
./scripts/run.sh [arguments...]
```

### Examples

- **General CLI Prompt**:
  ```bash
  ./scripts/run.sh --prompt "Analyze the workspace layout"
  ```

- **Pass options directly to the CLI**:
  ```bash
  ./scripts/run.sh --help
  ```

---

## Configuration & Customization

The helper script `scripts/run.sh` can be customized using environment variables:

| Environment Variable | Description | Default |
|----------------------|-------------|---------|
| `IMAGE` | The Docker image to execute. | `ghcr.io/asssaf/antigravity-cli:latest` |
| `AGY_HOST_CACHE` | Path to a directory on the host to mount as a persistent cache (`~/host-cache`). | *(Disabled if empty)* |
| `AGY_STARTUP_HOOK` | Path to an executable script (e.g. `scripts/dev-setup.sh`) to run prior to launching the CLI. | *(None)* |
| `PROJECT` | Suffix for the container name (`agy-${PROJECT}`). | Name of current directory |
| `GUEST_USER` | The username of the non-root user running inside the container. | `user` |
| `TZ` | Container timezone. | `America/Los_Angeles` |
| `COLORTERM` | Enables color rendering support inside the container. | `truecolor` |

### Cache Example

To run the container with a host cache directory mapped to `/home/user/host-cache` inside the container:

```bash
AGY_HOST_CACHE="/var/cache/agy" ./scripts/run.sh
```

### Startup Hook Example

To run a configuration or initialization script (e.g., configuring developer tools or environment tweaks) on startup:

```bash
AGY_STARTUP_HOOK="scripts/dev-setup.sh" ./scripts/run.sh
```

> [!NOTE]
> The `AGY_STARTUP_HOOK` script is sourced directly in the container entrypoint shell, which means any environment changes (such as modifying `PATH` or setting `GOROOT`) will persist into the `antigravity` agent process.

This repository supports toolchain and environment management using the **Mise** polyglot tool manager configured in [mise.toml](mise.toml). Sourcing [scripts/dev-setup.sh](scripts/dev-setup.sh) as the startup hook automatically bootstraps `mise` under `~/host-cache/mise/bin/`, installs the declared tools (such as Go, Node.js, or Elm), and activates them.


---

## Local Development

If you want to modify the container environment or build the Docker image locally, you can use the provided scripts.

### 1. Extract Latest Upstream Metadata
The `scripts/get-metadata.sh` script queries the official Google Antigravity installer manifests, parsing the latest version, download URLs, and SHA512 checksums for both architectures:

```bash
./scripts/get-metadata.sh
```

### 2. Build the Image Locally
The `scripts/build.sh` script uses the output of `get-metadata.sh` to construct the build-time arguments required by `docker/Dockerfile`:

```bash
# Build with default image name
./scripts/build.sh

# Build with a custom image name
IMAGE="my-local-antigravity:latest" ./scripts/build.sh
```

---

## CI/CD Workflow

The automated build-and-release pipeline defined in `.github/workflows/docker-ci.yml` performs the following operations:
1. **Periodic Check**: Runs on a weekly schedule (every Tuesday) or on direct pushes to `master`.
2. **Version Comparison**: Queries the official upstream Antigravity CLI version. If a new version is detected compared to the published tags, it triggers a release build.
3. **Multi-Arch Compilation**: Utilizes QEMU and Docker Buildx to cross-compile the image for both `linux/amd64` and `linux/arm64`.
4. **Publishing**: Pushes the compiled images to GitHub Container Registry (GHCR) and creates a new Git tag matching the upstream Antigravity version.

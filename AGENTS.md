# Agent Instructions

## GitHub Actions

When adding or modifying GitHub Actions workflows in this repository, you must use a specific commit hash for all actions instead of version tags. This ensures reproducibility and security.

Example:
```yaml
uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
```

To find the latest commit hash for an action, go to the releases page in the action's github repository, find the latest release and get its commit hash

## General Notes

- The primary branch for this repository is `master`.
- When making changes to the codebase, ensure that `README.md`  is updated if the changes are relevant to documented features.
- When installing a needed tool, try to install it using `mise` if available. Otherwise, install it to `~/host-cache/<tool>/<version>` by adding the installation commands to the `scripts/dev-setup.sh` script. Ensure the script checks if the specific tool version is already present before installing it, to avoid unnecessary downloads and prevent overwriting existing installations.

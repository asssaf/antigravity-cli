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


## Playwright

- **CRITICAL**: Do NOT attempt `playwright-cli open` or standard browser launches. You MUST connect to an existing Chromium instance via CDP.
- **Step 1: Ask for CDP Endpoint**: Before running any Playwright commands, ask the user to provide the Chromium remote debugging endpoint URL (e.g., `http://172.17.0.1:9223`).
- **Step 2: Attach**: Attach to the endpoint using `http://` (not `https://`):
  ```bash
  playwright-cli attach --cdp=http://<IP>:<PORT>
  ```
- **Step 3: Interact**: Control the page using standard `playwright-cli` commands (e.g., `playwright-cli goto "..."`, `playwright-cli snapshot`).
- **Step 4: Cleanup**: Close the session when finished using `playwright-cli close`.
- See the [playwright-cli skill](file:///home/user/work/.agents/skills/playwright-cli/SKILL.md) for full command details.

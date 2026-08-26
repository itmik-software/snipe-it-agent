# Device Sync for Snipe-IT

Installer distribution for Device Sync for Snipe-IT, a self-hosted Windows and macOS endpoint inventory bridge for Snipe-IT.

This repository provides released installers, deployment payloads, safe configuration templates, and operator documentation. It does not contain the agent source code or build instructions.

## Downloads

Download the latest release from the [GitHub Releases](https://github.com/itmik-software/snipe-it-agent/releases) page:

- Windows setup installer: `SnipeItAgentSetup.exe`
- Windows MSI installer: `SnipeItAgent.msi`
- Windows Intune package: `install.intunewin` from the latest release
- macOS disk image: `DeviceSyncForSnipeIt.dmg`

## Configuration

Start with `config/agentsettings.sample.json`. Replace the example Snipe-IT URL and token locally. Never commit a production API token or embed one in a broadly accessible deployment package.

Use a least-privilege Snipe-IT API token, keep TLS verification enabled, and restrict access to the installed configuration file.

## Deployment

- Windows: see `docs/installer-configuration.md` and `docs/intune-deployment-runbook.html`.
- macOS: see `docs/macos-deployment.md`.
- The Intune payload includes installation and uninstall scripts and is intended for managed deployment.

## Scope

Device Sync for Snipe-IT collects selected endpoint hardware and optional software details and creates or updates the matching hardware asset in Snipe-IT. It is not an RMM, EDR, patch-management, software-deployment, license-management, or compliance platform.

## Support

Report installer or configuration problems through [GitHub Issues](https://github.com/itmik-software/snipe-it-agent/issues). Support development through [GitHub Sponsors](https://github.com/sponsors/itmik-software).

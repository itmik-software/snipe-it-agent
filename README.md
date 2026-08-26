# Device Sync for Snipe-IT

[![Latest release](https://img.shields.io/github/v/release/itmik-software/snipe-it-agent?display_name=tag)](https://github.com/itmik-software/snipe-it-agent/releases)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS-147a7e)](https://github.com/itmik-software/snipe-it-agent/releases)

## Keep Snipe-IT accurate without manual asset entry

Device Sync for Snipe-IT is a self-hosted endpoint inventory agent for IT teams that use Snipe-IT as their hardware system of record. Install it on Windows PCs or Macs and it collects selected device details, then creates or updates the matching hardware asset in Snipe-IT.

It is built for the moment after deployment when the asset database starts drifting: laptops are reimaged, users change, models are missing, and nobody wants to ask for a serial number again. Device Sync turns that endpoint information into a repeatable inventory workflow.

## What it solves

- **Less manual asset administration:** discover serial numbers, manufacturers, models, hostnames, operating systems, CPU, memory, disk capacity, and primary MAC addresses from the endpoint.
- **More reliable ownership context:** detect a matching work-account identity and optionally assign the asset to an existing Snipe-IT user.
- **Cleaner Snipe-IT records:** find assets by serial number, create missing hardware records when configured, and map endpoint data into Snipe-IT custom fields.
- **A practical Microsoft rollout:** use the Windows setup installer, MSI, or supplied Intune package for managed deployment.
- **A safer pilot path:** inspect inventory, test connectivity, and preview a sync before writing changes to Snipe-IT.

## Choose your deployment

### Windows workstation or fleet

Download `DeviceSyncForSnipeIT.Setup.exe` for guided setup, or `DeviceSyncForSnipeIT-0.1.38.msi` for installer-managed deployment. For Microsoft-managed fleets, download `install.intunewin` from the release assets and deploy it as a Windows Win32 app.

### macOS

Download `DeviceSyncForSnipeIt.dmg`, open the setup application, enter your Snipe-IT connection details, and approve the administrator prompt. The installed agent runs as a launch daemon and supports a menu-bar control for manual sync.

## Quick evaluation

Start with a test Snipe-IT instance and a least-privilege API token. Use [the configuration template](config/agentsettings.sample.json), then:

1. Confirm the endpoint inventory contains the fields your asset workflow needs.
2. Test the Snipe-IT connection and permissions.
3. Run a dry-run and review the planned asset create/update.
4. Perform one real sync and verify the asset, custom fields, and optional assignment in Snipe-IT.

See [Windows installer configuration](docs/installer-configuration.md), [Intune deployment](docs/intune-deployment-runbook.md), and [macOS deployment](docs/macos-deployment.md).

## Configuration and security

Configuration is supplied for each environment rather than compiled into the application. Use a least-privilege Snipe-IT API token, keep TLS verification enabled, and restrict access to the installed configuration file. The current release uses a long-lived token in local configuration; short-lived enrollment and per-device credential rotation are not yet available. Never commit production credentials or place them in a broadly accessible package.

## Clear product boundaries

Device Sync for Snipe-IT is an inventory bridge, not an RMM, EDR, patch-management, software-deployment, license-management, or compliance platform. It performs one-way endpoint-to-Snipe-IT updates and does not delete stale assets or provide bidirectional reconciliation.

## Support the project

Device Sync for Snipe-IT is maintained independently by Itmik Software. Donations help fund Windows and macOS compatibility testing, signed releases, documentation, and Snipe-IT API improvements. Support development through [GitHub Sponsors](https://github.com/sponsors/itmik-software), or report installer and configuration problems through [GitHub Issues](https://github.com/itmik-software/snipe-it-agent/issues).

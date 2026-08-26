# Snipe-IT Agent for Windows and macOS

[![Latest release](https://img.shields.io/github/v/release/itmik-software/snipe-it-agent?display_name=tag)](https://github.com/itmik-software/snipe-it-agent/releases)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS-147a7e)](https://github.com/itmik-software/snipe-it-agent/releases)

## Keep Snipe-IT computer inventory accurate without manual asset entry

**Device Sync for Snipe-IT** is a lightweight Snipe-IT agent for IT teams that use Snipe-IT as their hardware system of record. It runs on Windows PCs and Macs and works with Snipe-IT Cloud, hosted Snipe-IT, and self-hosted Snipe-IT instances. Install it on your endpoints and it collects selected computer inventory details, then creates or updates the matching hardware asset in Snipe-IT.

It is built for the moment after deployment when the asset database starts drifting: laptops are reimaged, users change, models are missing, and nobody wants to ask for a serial number again. Device Sync turns that endpoint information into a repeatable inventory workflow.

Common use cases include Snipe-IT computer inventory, Windows asset discovery, macOS asset sync, Intune-deployed Snipe-IT automation, endpoint-to-Snipe-IT hardware updates, and replacing one-off PowerShell scripts with a repeatable agent.

## What it solves

- **Less manual asset administration:** discover serial numbers, manufacturers, models, hostnames, operating systems, CPU, memory, disk capacity, and primary MAC addresses from the endpoint.
- **More reliable ownership context:** detect a matching work-account identity and optionally assign the asset to an existing Snipe-IT user.
- **Cleaner Snipe-IT records:** find assets by serial number, create missing hardware records when configured, and map endpoint data into Snipe-IT custom fields.
- **Managed deployment options:** deploy Windows endpoints with the setup installer, MSI, and Intune Win32 app workflow; deploy Macs with the DMG or macOS Intune shell-script workflow.
- **Native macOS support:** sync Mac inventory to Snipe-IT with a macOS installer, launch daemon, and menu-bar control.

## Choose your deployment

### Windows workstation or fleet

Download `DeviceSyncForSnipeIT.Setup.exe` for guided setup, or `DeviceSyncForSnipeIT-0.1.38.msi` for installer-managed deployment. For Microsoft-managed Windows fleets, deploy the agent through the Intune Win32 app workflow.

### macOS

Download `DeviceSyncForSnipeIt.dmg`, open the setup application, enter your Snipe-IT connection details, and approve the administrator prompt. The installed Snipe-IT macOS agent runs as a launch daemon and supports a menu-bar control for manual sync. For managed Mac fleets, use the macOS Intune shell-script deployment workflow.

## Quick evaluation

Start with a test Snipe-IT instance and a least-privilege API token. Use [the configuration template](config/agentsettings.sample.json), then:

1. Confirm the endpoint inventory contains the fields your asset workflow needs.
2. Test the Snipe-IT connection and permissions.
3. Run a dry-run and review the planned asset create/update.
4. Perform one real sync and verify the asset, custom fields, and optional assignment in Snipe-IT.

See [Windows installer configuration](docs/installer-configuration.md), [Intune deployment](docs/intune-deployment-runbook.md), and [macOS deployment](docs/macos-deployment.md).

## Snipe-IT Agent FAQ

### Does Snipe-IT include a built-in computer inventory agent?

Snipe-IT provides a REST API and asset-management workflows, but endpoint inventory automation is usually handled by integrations, scripts, MDM systems, or third-party agents. Device Sync for Snipe-IT is an independent agent that sends selected computer inventory data into Snipe-IT through that API.

### Can this agent automatically add computers to Snipe-IT?

Yes. The agent can find assets by serial number, create missing hardware assets when enabled, update existing assets, resolve models and manufacturers, map custom fields, and optionally assign the asset to a matching Snipe-IT user.

### Can I deploy this Snipe-IT agent with Microsoft Intune?

Yes. Intune deployment is supported for both Windows and macOS. Windows uses the Intune Win32 app workflow; macOS uses an Intune shell script that installs a prepared payload archive.

### Is this an official Snipe-IT product?

No. Device Sync for Snipe-IT is an independent open-source integration published by Itmik Software. It is compatible with Snipe-IT, but it is not affiliated with, endorsed by, or sponsored by the Snipe-IT project.

## Configuration and security

Configuration is supplied for each environment rather than compiled into the application. Use a least-privilege Snipe-IT API token, keep TLS verification enabled, and restrict access to the installed configuration file. The current release uses a long-lived token in local configuration; short-lived enrollment and per-device credential rotation are not yet available. Never commit production credentials or place them in a broadly accessible package.

## Clear product boundaries

Device Sync for Snipe-IT is an inventory bridge, not an RMM, EDR, patch-management, software-deployment, license-management, or compliance platform. It performs one-way endpoint-to-Snipe-IT updates and does not delete stale assets or provide bidirectional reconciliation.

## Sponsor Snipe-IT agent development

Device Sync for Snipe-IT is maintained independently by Itmik Software. Donations help fund Windows and macOS compatibility testing, signed releases, documentation, and Snipe-IT API improvements. Support development through [GitHub Sponsors](https://github.com/sponsors/itmik-software), or report installer and configuration problems through [GitHub Issues](https://github.com/itmik-software/snipe-it-agent/issues).

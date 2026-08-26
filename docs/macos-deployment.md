# macOS Deployment

Use the supplied `installers/DeviceSyncForSnipeIt.dmg` for hands-on installation. This distribution repository does not include macOS source code or package-building instructions.

## Install

1. Open the DMG.
2. Open `Device Sync for Snipe-it Setup.app`.
3. Enter the Snipe-IT URL, identity domain, and API token.
4. Approve the administrator prompt.
5. Verify the first sync in Snipe-IT.

The installed agent uses a launch daemon and stores configuration and logs under:

```text
/Library/Application Support/DeviceSyncForSnipeIt/
/Library/DeviceSyncForSnipeIt/
```

## Configuration

Start with `config/agentsettings.sample.json`. Keep the production copy outside source control, use a least-privilege token, and keep TLS verification enabled. Installed software collection is optional and should be enabled only when it is appropriate for the organization's privacy requirements.

## Managed Mac deployment with Intune

Device Sync for Snipe-IT supports managed Mac deployment through an Intune shell script. The script installs a prepared payload archive, runs as root, and can be paired with a detection script to verify the installed agent, launch daemon, configuration file, and menu-bar app.

## Uninstall

Open the installed uninstall application or use the uninstall option provided by the setup package. Preserve configuration only when required for troubleshooting.

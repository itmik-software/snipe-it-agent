# Installer Configuration

## Before deployment

Use a non-production Snipe-IT instance first. Create a least-privilege API token and verify that the target status, model, category, manufacturer, user, custom-field, and hardware permissions are sufficient.

Copy `config/agentsettings.sample.json` to a private working location and set the Snipe-IT URL and API token. Never commit a production token or place one in a broadly accessible package. Keep TLS verification enabled and restrict access to the installed configuration file.

## Windows setup installer

1. Run `installers/SnipeItAgentSetup.exe` as an administrator.
2. Enter the Snipe-IT URL and API token when prompted.
3. Review status, category, and identity settings.
4. Complete setup and verify the `SnipeItAgent` service is running.

The setup installer writes configuration to:

```text
C:\ProgramData\Device Sync for Snipe-IT\agentsettings.json
```

The plain MSI installs application files and registers the service. It does not prompt for secrets, write configuration, or start the service by itself.

## Intune deployment

Use the supplied `intune/install.intunewin` package and the deployment settings documented by your organization's Intune administrator. Do not rebuild or repackage it from source. Supply tenant-specific configuration through your approved protected deployment process.

For a test deployment, verify the service, configuration path, local log, and resulting Snipe-IT asset on one device before expanding the assignment.

## macOS

Use the supplied `installers/DeviceSyncForSnipeIt.dmg`. Open the setup application, provide the Snipe-IT URL and token, and approve the administrator prompt. The installed configuration is stored under `/Library/Application Support/DeviceSyncForSnipeIt/`.

## Security note

The current distribution uses a long-lived bearer token in local configuration. Short-lived enrollment and per-device credential rotation are not yet available. Treat configuration files and deployment payloads as secrets until that capability exists.

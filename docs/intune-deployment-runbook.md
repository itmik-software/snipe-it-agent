# Windows Intune Deployment

This page covers the Windows Intune Win32 app workflow for Device Sync for Snipe-IT. Intune deployment is also supported for managed Macs through the macOS shell-script workflow; see [macOS deployment](macos-deployment.md).

## Recommended rollout

1. Create a protected tenant-specific configuration using `config/agentsettings.sample.json`.
2. Package and upload the Windows installer as an Intune Win32 app.
3. Configure install and uninstall commands according to the package metadata.
4. Assign the app to a small test device group.
5. Confirm service status, configuration, local logs, and the Snipe-IT asset.
6. Expand deployment only after the pilot succeeds.

Do not embed a production API token in a package that can be downloaded by users who do not need that credential. Use your organization's approved secret and configuration-delivery controls.

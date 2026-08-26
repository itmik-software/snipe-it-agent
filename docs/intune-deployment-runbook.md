# Intune Deployment

Download the supplied `install.intunewin` file from the latest GitHub Release and use it as a Windows Win32 app. This repository distributes the package; it does not publish the source or provide package-build instructions.

## Recommended rollout

1. Create a protected tenant-specific configuration using `config/agentsettings.sample.json`.
2. Upload `intune/install.intunewin` to Intune.
3. Configure install and uninstall commands according to the package metadata.
4. Assign the app to a small test device group.
5. Confirm service status, configuration, local logs, and the Snipe-IT asset.
6. Expand deployment only after the pilot succeeds.

Do not embed a production API token in a package that can be downloaded by users who do not need that credential. Use your organization's approved secret and configuration-delivery controls.

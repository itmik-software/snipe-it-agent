param(
    [string]$SourcePath = $PSScriptRoot,
    [string]$InstallPath = "$(if ($env:ProgramW6432) { $env:ProgramW6432 } else { $env:ProgramFiles })\Device Sync for Snipe-IT",
    [string]$ConfigPath = "$env:ProgramData\Device Sync for Snipe-IT\agentsettings.json",
    [string]$ServiceName = "SnipeItAgent"
)

$ErrorActionPreference = "Stop"

$serviceExe = Join-Path $InstallPath "DeviceSyncForSnipeIT.Service.exe"
$trayExe = Join-Path $InstallPath "DeviceSyncForSnipeIT.Tray.exe"
$configDir = Split-Path -Parent $ConfigPath
$legacyConfigPath = "$env:ProgramData\SnipeItAgent\agentsettings.json"
$runKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
$runValueName = "DeviceSyncForSnipeITTray"
$legacyRunValueName = "SnipeItAgentTray"
$uninstallKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\DeviceSyncForSnipeIT"

function Test-IsFalse {
    param([object]$Value)

    if ($null -eq $Value) {
        return $false
    }

    if ($Value -is [bool]) {
        return -not $Value
    }

    return "$Value".Equals("false", [StringComparison]::OrdinalIgnoreCase)
}

function Get-ConfiguredIdentityDomain {
    param([object]$Config)

    $upnSuffix = $Config.identity.upnSuffix
    if (-not [string]::IsNullOrWhiteSpace($upnSuffix)) {
        return "$upnSuffix".Trim().TrimStart("@")
    }

    $domain = $Config.identity.domain
    if (-not [string]::IsNullOrWhiteSpace($domain)) {
        return "$domain".Trim().TrimStart("@")
    }

    $legacySuffix = $Config.loggedInUserUpnSuffix
    if (-not [string]::IsNullOrWhiteSpace($legacySuffix)) {
        return "$legacySuffix".Trim().TrimStart("@")
    }

    return $null
}

function Assert-AgentConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        throw "Agent config was not found: $Path"
    }

    $config = Get-Content -Path $Path -Raw | ConvertFrom-Json

    if ([string]::IsNullOrWhiteSpace($config.snipeItUrl)) {
        throw "Agent config must include snipeItUrl."
    }

    if ([string]::IsNullOrWhiteSpace($config.apiToken) -or "$($config.apiToken)" -eq "paste-snipe-it-api-token-here") {
        throw "Agent config must include a deployment API token."
    }

    if (-not (Test-IsFalse $config.assignToLoggedInUser)) {
        $identityDomain = Get-ConfiguredIdentityDomain $config
        if ([string]::IsNullOrWhiteSpace($identityDomain)) {
            throw "Agent config must include identity.upnSuffix or identity.domain when assignToLoggedInUser is enabled. This is required so Intune LocalSystem service runs only assign assets to a Windows work account from the configured domain."
        }

        Write-Host "Intune install will assign assets only to Windows work accounts ending in @$identityDomain."
    }
}

Get-Process -Name "DeviceSyncForSnipeIT.Tray", "SnipeItAgent.Tray" -ErrorAction SilentlyContinue |
    Stop-Process -Force -ErrorAction SilentlyContinue

Remove-ItemProperty -Path $runKey -Name $legacyRunValueName -ErrorAction SilentlyContinue

$existing = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
if ($existing) {
    Stop-Service -Name $ServiceName -Force -ErrorAction SilentlyContinue
    sc.exe delete $ServiceName | Out-Null
    Start-Sleep -Seconds 2
}

New-Item -ItemType Directory -Force -Path $InstallPath | Out-Null
New-Item -ItemType Directory -Force -Path $configDir | Out-Null

Get-ChildItem -Path $SourcePath -Exclude "agentsettings.json", "agentsettings.sample.json" |
    Copy-Item -Destination $InstallPath -Recurse -Force

$packagedConfig = Join-Path $SourcePath "agentsettings.json"
if (Test-Path $packagedConfig) {
    Copy-Item -Path $packagedConfig -Destination $ConfigPath -Force
}
elseif ((-not (Test-Path $ConfigPath)) -and (Test-Path $legacyConfigPath)) {
    Copy-Item -Path $legacyConfigPath -Destination $ConfigPath -Force
}
elseif (-not (Test-Path $ConfigPath)) {
    $sampleConfig = Join-Path $SourcePath "agentsettings.sample.json"
    if (Test-Path $sampleConfig) {
        Copy-Item -Path $sampleConfig -Destination $ConfigPath -Force
    }
}

Assert-AgentConfig -Path $ConfigPath

New-Service `
    -Name $ServiceName `
    -DisplayName "Device Sync for Snipe-IT" `
    -Description "Syncs Windows inventory to Snipe-IT." `
    -BinaryPathName "`"$serviceExe`" --config `"$ConfigPath`"" `
    -StartupType Automatic | Out-Null

if (Test-Path $trayExe) {
    New-Item -Path $runKey -Force | Out-Null
    New-ItemProperty -Path $runKey -Name $runValueName -Value "`"$trayExe`"" -PropertyType String -Force | Out-Null
}

New-Item -Path $uninstallKey -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "DisplayName" -Value "Device Sync for Snipe-IT" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "DisplayVersion" -Value "0.1.38" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "Publisher" -Value "Itmik Software" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "InstallLocation" -Value $InstallPath -PropertyType String -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "DisplayIcon" -Value (Join-Path $InstallPath "device-sync.ico") -PropertyType String -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "UninstallString" -Value "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$InstallPath\uninstall.ps1`"" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "QuietUninstallString" -Value "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$InstallPath\uninstall.ps1`"" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "NoModify" -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $uninstallKey -Name "NoRepair" -Value 1 -PropertyType DWord -Force | Out-Null

Start-Service -Name $ServiceName

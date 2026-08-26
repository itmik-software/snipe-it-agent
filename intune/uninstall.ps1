param(
    [string]$InstallPath = "$(if ($env:ProgramW6432) { $env:ProgramW6432 } else { $env:ProgramFiles })\Device Sync for Snipe-IT",
    [string]$ServiceName = "SnipeItAgent",
    [string]$ConfigRoot = "$env:ProgramData\Device Sync for Snipe-IT",
    [switch]$PreserveConfig
)

$ErrorActionPreference = "Stop"

$runKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
$uninstallKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\DeviceSyncForSnipeIT"

function Stop-TrayProcess {
    $deadline = [DateTime]::UtcNow.AddSeconds(30)
    $names = @("DeviceSyncForSnipeIT.Tray", "SnipeItAgent.Tray")

    do {
        $running = Get-Process -Name $names -ErrorAction SilentlyContinue
        if (-not $running) {
            return
        }

        $running | Stop-Process -Force -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 500
    } while ([DateTime]::UtcNow -lt $deadline)

    $stillRunning = Get-Process -Name $names -ErrorAction SilentlyContinue
    if ($stillRunning) {
        $processNames = ($stillRunning | Select-Object -ExpandProperty ProcessName -Unique) -join ", "
        throw "Could not close the Device Sync for Snipe-IT system tray app. Close it and run uninstall again. Still running: $processNames"
    }
}

Stop-TrayProcess
Remove-ItemProperty -Path $runKey -Name "DeviceSyncForSnipeITTray" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $runKey -Name "SnipeItAgentTray" -ErrorAction SilentlyContinue
Remove-Item -Path $uninstallKey -Recurse -Force -ErrorAction SilentlyContinue

$existing = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
if ($existing) {
    Stop-Service -Name $ServiceName -Force -ErrorAction SilentlyContinue
    sc.exe delete $ServiceName | Out-Null
    Start-Sleep -Seconds 2
}

if (Test-Path $InstallPath) {
    Remove-Item -Path $InstallPath -Recurse -Force
}

$x86InstallPath = "${env:ProgramFiles(x86)}\Device Sync for Snipe-IT"
if (-not [string]::IsNullOrWhiteSpace(${env:ProgramFiles(x86)}) -and (Test-Path $x86InstallPath)) {
    Remove-Item -Path $x86InstallPath -Recurse -Force
}

$legacyInstallPath = "$env:ProgramFiles\SnipeItAgent"
if (Test-Path $legacyInstallPath) {
    Remove-Item -Path $legacyInstallPath -Recurse -Force
}

if (-not $PreserveConfig) {
    if (Test-Path $ConfigRoot) {
        Remove-Item -Path $ConfigRoot -Recurse -Force
    }

    $legacyConfigRoot = "$env:ProgramData\SnipeItAgent"
    if (Test-Path $legacyConfigRoot) {
        Remove-Item -Path $legacyConfigRoot -Recurse -Force
    }
}

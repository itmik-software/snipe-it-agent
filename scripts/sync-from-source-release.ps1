param(
    [string]$Tag = "v0.1.1",
    [string]$SourceRepo = "itmik-software/snipe-it-agent-source",
    [string]$SourceCheckout = "..\snipe-it-agent",
    [string]$DistributionRoot = ".",
    [string]$PublicRepo = "itmik-software/snipe-it-agent",
    [string]$PublicReleaseTag = "v0.1.38",
    [switch]$UploadPublicRelease,
    [switch]$IncludeWindowsIntune
)

$ErrorActionPreference = "Stop"

function Resolve-FullPath {
    param([string]$Path)
    return [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $Path))
}

function Copy-IfChanged {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (!(Test-Path -LiteralPath $Source -PathType Leaf)) {
        throw "Source file not found: $Source"
    }

    $destinationDirectory = Split-Path -Parent $Destination
    if (!(Test-Path -LiteralPath $destinationDirectory -PathType Container)) {
        New-Item -ItemType Directory -Path $destinationDirectory | Out-Null
    }

    if (Test-Path -LiteralPath $Destination -PathType Leaf) {
        $sourceHash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash
        $destinationHash = (Get-FileHash -LiteralPath $Destination -Algorithm SHA256).Hash
        if ($sourceHash -eq $destinationHash) {
            Write-Host "Unchanged: $Destination"
            return
        }
    }

    Copy-Item -LiteralPath $Source -Destination $Destination -Force
    Write-Host "Copied: $Destination"
}

$distributionRootFull = Resolve-FullPath $DistributionRoot
$sourceCheckoutFull = Resolve-FullPath $SourceCheckout
$installersRoot = Join-Path $distributionRootFull "installers"
$intuneRoot = Join-Path $distributionRootFull "intune"

if (!(Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI 'gh' is required to download source release assets."
}

New-Item -ItemType Directory -Path $installersRoot -Force | Out-Null

Write-Host "Downloading macOS release assets from $SourceRepo $Tag..."
gh release download $Tag `
    --repo $SourceRepo `
    --pattern "DeviceSyncForSnipeIt-*.dmg*" `
    --dir $installersRoot `
    --clobber

Get-ChildItem -LiteralPath $installersRoot -Filter "DeviceSyncForSnipeIt-*.dmg" | ForEach-Object {
    $hashFile = "$($_.FullName).sha256"
    if (Test-Path -LiteralPath $hashFile -PathType Leaf) {
        $expectedHash = ((Get-Content -LiteralPath $hashFile -Raw) -split "\s+")[0]
        $actualHash = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($actualHash -ne $expectedHash.ToLowerInvariant()) {
            throw "Checksum mismatch for $($_.Name). Expected $expectedHash but found $actualHash."
        }

        Write-Host "Verified: $($_.Name)"
    }
}

if ($UploadPublicRelease) {
    $releaseAssets = Get-ChildItem -LiteralPath $installersRoot -File |
        Where-Object { $_.Name -like "DeviceSyncForSnipeIt-*.dmg" -or $_.Name -like "DeviceSyncForSnipeIt-*.dmg.sha256" }

    if ($releaseAssets.Count -eq 0) {
        throw "No macOS release assets found under $installersRoot."
    }

    Write-Host "Uploading macOS assets to $PublicRepo $PublicReleaseTag..."
    gh release upload $PublicReleaseTag `
        @($releaseAssets.FullName) `
        --repo $PublicRepo `
        --clobber
}

if ($IncludeWindowsIntune) {
    Copy-IfChanged `
        -Source (Join-Path $sourceCheckoutFull "artifacts\intunewin\install.intunewin") `
        -Destination (Join-Path $intuneRoot "install.intunewin")

    foreach ($fileName in @("install.ps1", "uninstall.ps1", "agentsettings.sample.json")) {
        Copy-IfChanged `
            -Source (Join-Path $sourceCheckoutFull "artifacts\intune-package\$fileName") `
            -Destination (Join-Path $intuneRoot $fileName)
    }
}

Write-Host "Done."

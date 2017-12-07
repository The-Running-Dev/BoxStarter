$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$baseDir = Join-Path $PSScriptRoot 'Chocolatey-Base'
$baseZip = Join-Path $baseDir 'Chocolatey-Base.zip'

if (Test-Path $baseZip) {
    Remove-Item $baseZip -Force | Out-Null
}

$externalPackagesUpdateScript = Join-Path $PSScriptRoot '.\update.external.ps1' -Resolve

$packages = @(
    'Chocolatey'
    'Chocolatey.extension'
    'Chocolatey-Core.extension'
    'Chocolatey-Personal'
    'PowerShell-Carbon'
    'PowerShell-CommunityExtensions'
    'PowerShell-Helpers.extension'
    'PowerShell-Profile'
    'PowerShell-PSake'
)

$localPackagesBuildScript = Join-Path $PSScriptRoot '..\build-push.ps1' -Resolve
$localPackages = @(
    'PowerShell-Carbon'
    'PowerShell-CommunityExtensions'
    'PowerShell-Helpers.extension'
    'PowerShell-PSake'
)

$localPrivatePackagesBuildScript = Join-Path $PSScriptRoot '..\..\BoxStarter-Private\build-push.ps1' -Resolve
$localPrivatePackages = @(
    'Chocolatey-Personal'
    'PowerShell-Profile'
)

& $externalPackagesUpdateScript

$localPackages | ForEach-Object {
    & $localPackagesBuildScript $_
}

$localPrivatePackages | ForEach-Object {
    & $localPrivatePackagesBuildScript $_
}

Get-ChildItem $packagesDir | `
    Where-Object {
    $packages -contains ($_.Name -replace '(.*?)\.([0-9\.]+)\.nupkg', '$1')
} | Compress-Archive -DestinationPath $baseZip

Compress-Archive "$PSScriptRoot\install.choco.ps1" -Update $baseZip
$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$baseDir = Join-Path $PSScriptRoot 'Chocolatey-Base'
$baseZip = Join-Path $baseDir 'Chocolatey-Base.zip'

if (Test-Path $baseZip) {
    Remove-Item $baseZip -Force | Out-Null
}

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

$localPackages = @(
    'PowerShell-Carbon'
    'PowerShell-CommunityExtensions'
    'PowerShell-Helpers.extension'
    'PowerShell-PSake'
)

$localPrivatePackages = @(
    'Chocolatey-Personal'
    'PowerShell-Profile'
)

$localPackages | ForEach-Object {
    & (Join-Path $PSScriptRoot '..\build-push.ps1' -Resolve) $_
}

$localPrivatePackages | ForEach-Object {
    & (Join-Path $PSScriptRoot '..\..\BoxStarter-Private\build-push.ps1' -Resolve) $_
}
<#
Get-ChildItem $packagesDir | `
    Where-Object {
    $packages -contains ($_.Name -replace '(.*?)\.([0-9\.]+)\.nupkg', '$1')
} | Compress-Archive -DestinationPath $baseZip

Compress-Archive "$PSScriptRoot\install.choco.ps1" -Update $baseZip
#>
$packagesDir = Join-Path $PSScriptRoot '..\..\BoxStarter' -Resolve
$baseDir = Join-Path $PSScriptRoot 'Chocolatey-Base'
$baseZip = Join-Path $baseDir 'Chocolatey-Base.zip'

Remove-Item $baseZip -Force | Out-Null

$packages = @(
    'Chocolatey'
    'Chocolatey.extension'
    'Chocolatey-Core.extension'
    'Chocolatey-Dev.extension'
    'Chocolatey-Package.extension'
    'Chocolatey-Personal'
    'NuGet-CommandLine'
    'Octopus-Deploy-CommandLine'
    'PowerShell-Carbon'
    'PowerShell-CommunityExtensions'
    'PowerShell-Profile'
    'PowerShell-PSake'
)

Get-ChildItem $packagesDir | `
    Where-Object {
    $packages -contains ($_.Name -replace '(.*?)\.([0-9\.]+)\.nupkg', '$1')
} | Compress-Archive -DestinationPath $baseZip

Compress-Archive "$PSScriptRoot\install.choco.ps1" -Update $baseZip
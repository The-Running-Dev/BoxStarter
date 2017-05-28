$parentDir = Join-Path $PSScriptRoot '..\' -Resolve
$boxstarterPrivateDir = Join-Path $PSScriptRoot '..\..\Boxstarter-Private' -Resolve
$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$baseDir = Resolve-FullPath (Join-Path $PSScriptRoot '..\Base')
$baseZip = Join-Path $baseDir 'Base.zip'

$originalLocation = Get-Location

Remove-Item -Recurse $baseDir -Force -ErrorAction SilentlyContinue | Out-Null
New-Item -ItemType Directory $baseDir -Force | Out-Null

& $parentDir\build-push.ps1 Chocolatey

& $parentDir\Scripts\build.chocolatey-dev.extension.ps1
& $parentDir\Scripts\build.chocolatey-package.extension.ps1
& $boxstarterPrivateDir\build-push.ps1 PowerShell-Profile -f
& $boxstarterPrivateDir\build-push.ps1 Chocolatey-Personal -f

$include = @()
$include += 'Chocolatey'
$include += 'Chocolatey.extension'
$include += 'Chocolatey-Core.extension'
$include += 'Chocolatey-Dev.extension'
$include += 'Chocolatey-Package.extension'
$include += 'Chocolatey-Personal'
$include += 'NuGet-CommandLine'
$include += 'Octopus-Deploy-CommandLine'
$include += 'PowerShell-Carbon'
$include += 'PowerShell-CommunityExtensions'
$include += 'PowerShell-Profile'
$include += 'PowerShell-PSake'

Remove-Item -Recurse $baseDir -ErrorAction SilentlyContinue
New-Item -ItemType Directory $baseDir -force | Out-Null

Get-ChildItem $packagesDir | `
    Where-Object {
        $include -contains ($_.Name -replace '(.*?)\.([0-9\.]+)\.nupkg', '$1')
    } | Compress-Archive -DestinationPath $baseZip

Compress-Archive "$PSScriptRoot\install.choco.ps1" -Update $baseZip
Copy-Item "$PSScriptRoot\install.base.ps1" $baseDir\

Set-Location $originalLocation
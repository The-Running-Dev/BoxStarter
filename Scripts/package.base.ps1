$publishDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$baseDir = Resolve-FullPath (Join-Path $PSScriptRoot '..\Base')
$baseZip = Join-Path $baseDir 'Base.zip'

$include = @()
$include += 'carbon'
$include += 'chocolatey'
$include += 'Chocolatey.extension'
$include += 'Chocolatey-Core.extension'
$include += 'Chocolatey-Dev.extension'
$include += 'Chocolatey-Package.extension'
$include += 'Chocolatey-Personal'
$include += 'NuGet-CommandLine'
$include += 'Octopus-Tools'
$include += 'psake'
$include += 'pscx'
$include += 'Windows-Powershell-Personal'

Remove-Item -Recurse $baseDir -ErrorAction SilentlyContinue
New-Item -ItemType Directory $baseDir -force | Out-Null

Get-ChildItem $publishDir | `
    Where-Object {
        $include -contains ($_.Name -replace '(.*?)\.([0-9\.]+)\.nupkg', '$1')
    } | Compress-Archive -DestinationPath $baseZip

Compress-Archive "$PSScriptRoot\install.choco.ps1" -Update $baseZip
Copy-Item "$PSScriptRoot\install.base.ps1" $baseDir\
param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local',
    [switch] $force
)

Import-Module "$PSScriptRoot\Chocolatey-Package.extension\extensions\Chocolatey-Package.extension.psm1" -Force
Import-Module "$PSScriptRoot\Chocolatey-Dev.extension\extensions\Chocolatey-Dev.extension.psm1" -Force

#Clear-Host

if ($force) {
    & $PSScriptRoot\build.ps1 $searchTerm $sourceType -Force
}
else {
    & $PSScriptRoot\build.ps1 $searchTerm $sourceType
}

& $PSScriptRoot\push.ps1 $searchTerm $sourceType
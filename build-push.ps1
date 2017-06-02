param (
    [Parameter(Position = 0)][String] $searchTerm,
    [Parameter(Position = 1)][switch] $remote,
    [Parameter(Position = 2)][switch] $force
)

Import-Module "$PSScriptRoot\Chocolatey-Package.extension\extensions\Chocolatey-Package.extension.psm1" -Force
Import-Module "$PSScriptRoot\Chocolatey-Dev.extension\extensions\Chocolatey-Dev.extension.psm1" -Force

Clear-Host

& $PSScriptRoot\build.ps1 $searchTerm $remote $force

& $PSScriptRoot\push.ps1 $searchTerm $remote $force
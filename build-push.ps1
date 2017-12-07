param (
    [Parameter(Position = 0)][String] $searchTerm,
    [Parameter(Position = 1)][switch] $remote,
    [Parameter(Position = 2)][switch] $force
)

Import-Module "$PSScriptRoot\PowerShell-Helpers.extension\extensions\PowerShell-Helpers.extension.psm1" -Force

& $PSScriptRoot\build.ps1 $searchTerm $remote $force

& $PSScriptRoot\push.ps1 $searchTerm $remote $force
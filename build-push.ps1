param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local',
    [switch] $force
)

Clear-Host

if ($force) {
    & $PSScriptRoot\build.ps1 $searchTerm $sourceType -Force
}
else {
    & $PSScriptRoot\build.ps1 $searchTerm $sourceType
}

& $PSScriptRoot\push.ps1 $searchTerm $sourceType